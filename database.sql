CREATE SCHEMA mydatabase;

use mydatabase;

CREATE TABLE complex (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
    nom_complex VARCHAR(255) NOT NULL,
    ville VARCHAR(255) NOT NULL
);

CREATE TABLE salle (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
    id_complex INT NOT NULL,
    num_salle INT NOT NULL,
    places_max INT NOT NULL,
    FOREIGN KEY (id_complex) REFERENCES complex (id)
);

CREATE TABLE film (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    titre VARCHAR(255) NOT NULL,
    realisateur VARCHAR(255) NOT NULL,
    duree TIME NOT NULL
);


CREATE TABLE seance (
    id_attribution INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_complex INT NOT NULL,
    id_salle INT NOT NULL,
    id_film INT NOT NULL,
    date_diffusion DATE NOT NULL,
    heure_debut TIME NOT NULL,
    places_restantes INT NOT NULL DEFAULT 0,
    FOREIGN KEY (id_complex) REFERENCES complex (id),
    FOREIGN KEY (id_salle) REFERENCES salle (id),
    FOREIGN KEY (id_film) REFERENCES film (id)
);

CREATE TABLE reservations (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    seance_reservee INT NOT NULL,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255)NOT NULL,
    email VARCHAR(255)NOT NULL,
    nb_places INT NOT NULL,
    e_paiement BOOLEAN NOT NULL,
    montant_total DECIMAL(5, 2) NOT NULL DEFAULT '0.00',
    date_paiement TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (seance_reservee) REFERENCES seance (id_attribution)
);

CREATE TABLE tarif (
    tarif_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nom_tarif VARCHAR(255) NOT NULL,
    montant DECIMAL(5, 2) NOT NULL
);

CREATE TABLE jointure_reservation (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    reservation_id INT NOT NULL,
    tarif_id INT NOT NULL,
    quantite INT NOT NULL,
    FOREIGN KEY (reservation_id) REFERENCES reservations (id),
    FOREIGN KEY (tarif_id) REFERENCES tarif (tarif_id)
);

/* ----------------------------------------------------------- */

-- TRIGGER AJOUT SEANCES -> 
    -- Controle de la relation entre la salle et le complex.
DELIMITER //
CREATE TRIGGER check_seance_true
BEFORE INSERT ON seance
FOR EACH ROW
BEGIN
    DECLARE id_complex_salle INT;
    SELECT id_complex INTO id_complex_salle 
    FROM salle 
    WHERE id = NEW.id_salle;
    IF NEW.id_complex <> id_complex_salle THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La salle n appartient pas au complex';
    END IF;
END;
//
DELIMITER ;

-- TRIGGER CALCUL DU MONTANT DE LA RÉSERVATION ->
DELIMITER //
CREATE TRIGGER calcul_montant
AFTER INSERT ON jointure_reservation
FOR EACH ROW
BEGIN
    DECLARE total DECIMAL(5, 2);
    
    SELECT SUM(tarif.montant * jointure_reservation.quantite) INTO total
    FROM jointure_reservation
    JOIN tarif ON jointure_reservation.tarif_id = tarif.tarif_id
    WHERE jointure_reservation.reservation_id = NEW.reservation_id;
    
    UPDATE reservations
    SET montant_total = total
    WHERE id = NEW.reservation_id;
END;
//
DELIMITER ;

-- TRIGGER DÉFINI LE NOMBRE DE PLACE DE LA SEANCE SELON LA SALLE ATTRIBUÉE.
DELIMITER //
CREATE TRIGGER init_place_par_seance
BEFORE INSERT ON seance
FOR EACH ROW
BEGIN
    DECLARE placesmax INT;

    SELECT places_max INTO placesmax
    FROM salle
    WHERE NEW.id_salle = salle.id;

    SET NEW.places_restantes = placesmax;
END;
//
DELIMITER ;

-- TRIGGER CHECK NOMBRE DE PLACE DISPO
DELIMITER //
CREATE TRIGGER check_places
BEFORE INSERT ON reservations
FOR EACH ROW
BEGIN
    DECLARE checking INT;
    SELECT places_restantes INTO checking 
    FROM seance 
    WHERE id_attribution = NEW.seance_reservee;

    IF NEW.nb_places > checking THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Pas assez de place disponible';
    END IF;
END;
//
DELIMITER ;


-- TRIGGER SOUSTRAIT LE NOMBRE DE PLACES RESTANTE À LA SEANCE SELON NOMBRE DE PLACE RESERVÉE
DELIMITER //
CREATE TRIGGER soustraction_places
AFTER INSERT ON reservations
FOR EACH ROW
BEGIN
    DECLARE valeur INT;

    SELECT nb_places INTO valeur
    FROM reservations
    WHERE NEW.id = reservations.id;

    UPDATE seance
    SET places_restantes = places_restantes - valeur
    WHERE id_attribution = NEW.seance_reservee;
END;
//
DELIMITER ;

-- TRIGGER EN CAS DE SUPPRESSION DE RESERVATION
DELIMITER //
CREATE TRIGGER supprs_reservation
BEFORE DELETE ON reservations
FOR EACH ROW
BEGIN
    DECLARE valeur INT;

    SELECT nb_places INTO valeur
    FROM reservations
    WHERE id = OLD.id;

    UPDATE seance
    SET places_restantes = places_restantes + valeur
    WHERE id_attribution = OLD.seance_reservee;
END;
//
DELIMITER ;
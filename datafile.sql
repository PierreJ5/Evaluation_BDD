use mydatabase;

INSERT INTO complex (nom_complex, ville)
VALUES
('complex Parisien', 'Paris'), ('complex Lillois', 'Lille'),
('complex Lyonnais - B1', 'Lyon'), ('complex Lyonnais - B2', 'Lyon');

INSERT INTO salle (id_complex, num_salle, places_max)
VALUES
(1, 101, 100), (1, 102, 100), (1, 103, 150), (1, 104, 100), (1, 105, 150),
(1, 201, 100), (1, 202, 100), (1, 203, 150), (1, 204, 100), (1, 205, 150),

(2, 101, 100), (2, 102, 100), (2, 103, 150), (2, 104, 100), (2, 105, 150),
(2, 201, 100), (2, 202, 100), (2, 203, 150), (2, 204, 100), (2, 205, 150),
(2, 301, 300),

(3, 101, 100), (3, 102, 100), (3, 103, 150), (3, 104, 100), (3, 105, 150),
(3, 201, 100), (3, 202, 100), (3, 203, 150),

(4, 101, 200), (4, 102, 200), (4, 103, 250), (4, 104, 300), (4, 105, 300),
(4, 201, 100), (4, 202, 100), (4, 203, 150);

INSERT INTO film (titre, realisateur, duree)
VALUES
('Spiderman Homecoming', 'Arnold Schwarzi', '01:25:00'), ('Conan le Barbare', 'Arnold Schwarzi', '01:32:00'),
('Les indestructibles', 'Arnold Schwarzi', '01:31:00'), ('Le Seigneur des Anneaux - Les deux Tours', 'Arnold Schwarzi', '02:14:00'),
('John Carter', 'Arnold Schwarzi', '01:45:00'), ('Ratatouille', 'Arnold Schwarzi', '01:32:00'),
('Resident Evil - Extinction', 'Arnold Schwarzi', '01:22:34'), ('Matrix', 'Arnold Schwarzi', '01:50:00');

INSERT INTO seance (id_salle, id_complex, id_film, heure_debut, date_diffusion)
VALUES
(1, 1, 1, '18:00:00', '2023-12-25'), (1, 1, 5, '21:00:00', '2023-12-25'), (2, 1, 8, '18:00:00', '2023-12-25'), (3, 1, 7, '20:00:00', '2023-12-26'),
(11, 2, 1, '18:00:00', '2023-12-25'), (12, 2, 5, '21:00:00', '2023-12-25'), (13, 2, 4, '18:00:00', '2023-12-25'), (13, 2, 3, '20:00:00', '2023-12-26'),
(22, 3, 1, '18:00:00', '2023-12-25'), (23, 3, 5, '21:00:00', '2023-12-25'), (24, 3, 8, '18:00:00', '2023-12-25'), (25, 3, 7, '20:00:00', '2023-12-26'),
(30, 4, 2, '18:00:00', '2023-12-25'), (31, 4, 5, '21:00:00', '2023-12-25'), (32, 4, 2, '18:00:00', '2023-12-25'), (33, 4, 7, '20:00:00', '2023-12-26'),
(27, 3, 2, '19:00:00', '2023-12-27'), (31, 4, 5, '22:00:00', '2023-12-27'), (2, 1, 2, '19:00:00', '2023-12-27'), (33, 4, 7, '20:00:00', '2023-12-28');

INSERT INTO tarif (nom_tarif, montant)
VALUES
('Tarif Plein', 9.20),
('Tarif Étudiant', 7.60),
('Tarif Moins 14 ans', 5.90);

INSERT INTO reservations (seance_reservee, nom, prenom, email, nb_places, e_paiement)
VALUES
(1, 'Doe', 'John', 'johndoe@example.com', 3, 1),
(1, 'Doe', 'Jeanne', 'jeannedoe@example.com', 8, 1),
(1, 'Doe', 'Gary', 'garydoe@example.com', 1, 0),
(1, 'Doe', 'Alphonse', 'alphonsedoe@example.com', 5, 0),
(1, 'Doe', 'Tom', 'tomdoe@example.com', 15, 0),

(2, 'Couturier', 'Sarah', 'sarahcouturier@example.com', 3, 1),
(2, 'Couturier', 'Pierre', 'pierrecouturier@example.com', 3, 1),

(4, 'Hassani', 'Eli', 'elihassani@example.com', 2, 1),
(4, 'Hassani', 'John', 'hohnhassani@example.com', 7, 1),
(4, 'Hassani', 'Jeanne', 'jeannehassani@example.com', 6, 1),
(4, 'Hassani', 'Marvin', 'marvinhassani@example.com', 12, 0),

(5, 'Smith', 'Robert', 'robertsmith@example.com', 2, 1),
(5, 'Smith', 'Carla', 'carlasmith@example.com', 2, 0),
(5, 'Smith', 'Marie', 'mariesmith@example.com', 5, 1);


INSERT INTO jointure_reservation (reservation_id, tarif_id, quantite)
VALUES
(1, 1, 1), (1, 3, 2),
(2, 1, 2), (2, 3, 6),
(3, 2, 1),
(4, 1, 2), (4, 3, 3),
(5, 1, 1), (5, 3, 14),

(6, 1, 1), (6, 3, 2),
(7, 1, 1), (7, 3, 2),
(8, 2, 2),
(9, 1, 3), (9, 2, 1), (9, 3, 3),
(10, 1, 3), (10, 3, 3),
(11, 1, 4), (11, 3, 8),
(12, 2, 2),
(13, 1, 2),
(14, 1, 1), (14, 3, 4);


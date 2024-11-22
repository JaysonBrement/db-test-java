CREATE TABLE categorie (
   id_categorie INT AUTO_INCREMENT,
   nom VARCHAR(50),
   couleur_css_hexadecimal varchar(10),
   PRIMARY KEY(id_categorie)
);

-- Subcategories of products (e.g., Ice Cream under Desserts)
CREATE TABLE sous_categorie (
   id_sous_categorie INT AUTO_INCREMENT,
   nom VARCHAR(50),
   id_categorie INT NOT NULL,
   couleur_css_hexadecimal varchar(10),
   PRIMARY KEY(id_sous_categorie),
   FOREIGN KEY(id_categorie) REFERENCES categorie(id_categorie)
);

-- Supplements available for products (e.g., Chocolate Chips, Syrup)
CREATE TABLE supplement (
   id_supplement INT AUTO_INCREMENT,
   nom VARCHAR(30),
   prix DECIMAL(5,2),
   PRIMARY KEY(id_supplement)
);

-- Tables assigned to customers
CREATE TABLE table_client (
   id_table_client INT AUTO_INCREMENT,
   PRIMARY KEY(id_table_client)
);

-- Products on the menu
CREATE TABLE produit (
   id_produit INT AUTO_INCREMENT,
   nom VARCHAR(30),
   prix DECIMAL(6,2),
   couleur_css_hexadecimal varchar(10),
   id_sous_categorie INT NOT NULL,
   id_categorie INT NOT NULL,
   PRIMARY KEY(id_produit),
   FOREIGN KEY(id_sous_categorie) REFERENCES sous_categorie(id_sous_categorie),
   FOREIGN KEY(id_categorie) REFERENCES categorie(id_categorie)
);
CREATE TABLE user (
   id_user INT AUTO_INCREMENT,
   nom varchar(30),
   identifiant INT,
   PRIMARY KEY(id_user)
);
-- Orders (commande) placed by customers
CREATE TABLE commande (
   id_commande INT AUTO_INCREMENT,
   id_table_client INT NOT NULL,
   id_user INT NOT NULL,
   PRIMARY KEY(id_commande),
   UNIQUE(id_table_client),  
   FOREIGN KEY(id_table_client) REFERENCES table_client(id_table_client),
   Foreign KEY(id_user) REFERENCES user(id_user)
);

-- Comments about products
CREATE TABLE commentaire (
   id_commentaire INT AUTO_INCREMENT,
   contenu VARCHAR(100),
   id_produit INT NOT NULL,
   PRIMARY KEY(id_commentaire),
   UNIQUE(id_produit),
   FOREIGN KEY(id_produit) REFERENCES produit(id_produit)
);


CREATE TABLE produits_supplements (
   id_produit INT,
   id_supplement INT,
   PRIMARY KEY(id_produit, id_supplement),
   FOREIGN KEY(id_produit) REFERENCES produit(id_produit),
   FOREIGN KEY(id_supplement) REFERENCES supplement(id_supplement)
);

CREATE TABLE commande_produit_supplement (
    id_commande_produit_supplement INT AUTO_INCREMENT,
    id_commande INT NOT NULL,
    id_produit INT NOT NULL,
    id_supplement INT NOT NULL,
    supplement_associer INT DEFAULT NULL,
    PRIMARY KEY (id_commande_produit_supplement),
    FOREIGN KEY (id_commande) REFERENCES commande(id_commande),
    FOREIGN KEY (id_produit) REFERENCES produit(id_produit),
    FOREIGN KEY (id_supplement) REFERENCES supplement(id_supplement),
    FOREIGN KEY (supplement_associer) REFERENCES commande_produit_supplement(id_commande_produit_supplement)
);
CREATE TABLE IF NOT EXISTS Position (
    ID INTEGER PRIMARY KEY,
    Ra FLOAT,  -- Right Ascension
    [Dec] FLOAT  -- Declination
);

CREATE TABLE IF NOT EXISTS Celestial_Body (
    ID INTEGER PRIMARY KEY,
    [Name] VARCHAR(255) NOT NULL,
    Mass FLOAT,
    Radius FLOAT,
    [Type] VARCHAR(50) NOT NULL CHECK ([Type] IN ('Planet', 'Star', 'Galaxy', 'Nebula', 'Satellite')),
    Subtype VARCHAR(50),
    Discovery_Date DATE,
    Composition_Details TEXT,
    Last_Observation DATE,
    ID_Position INTEGER,
    Planetary_System_ID INTEGER,
    Discoverer_ID INTEGER,

    FOREIGN KEY (Planetary_System_ID) REFERENCES Planetary_System(ID),
    FOREIGN KEY (Discoverer_ID) REFERENCES Discoverer(ID),
    FOREIGN KEY (ID_Position) REFERENCES Position(ID)
);

CREATE TABLE IF NOT EXISTS Planet (
    ID INTEGER,
    Orbit_Period FLOAT,
    Atmosphere_Density FLOAT,
    Surface_Temperature FLOAT,
    Number_of_Moons INTEGER,

    FOREIGN KEY (ID) REFERENCES Celestial_Body(ID)
);

CREATE TABLE IF NOT EXISTS Star (
    ID INTEGER,
    Spectral_Type VARCHAR(10),
    Luminosity FLOAT,
    Temperature FLOAT,
    Age FLOAT,
    Metallicity FLOAT,

    FOREIGN KEY (ID) REFERENCES Celestial_Body(ID)
);

CREATE TABLE IF NOT EXISTS Galaxy (
    ID INTEGER,
    Galaxy_Type VARCHAR(50),
    Diameter FLOAT,
    Number_of_Stars BIGINT,
    Distance FLOAT,
    Redshift FLOAT,

    FOREIGN KEY (ID) REFERENCES Celestial_Body(ID)
);

CREATE TABLE IF NOT EXISTS Nebula (
    ID INTEGER,
    Nebula_Type VARCHAR(50),
    Size FLOAT,
    Brightness FLOAT,
    Gas_Density FLOAT,
    Associated_Star_ID INTEGER,

    FOREIGN KEY (ID) REFERENCES Celestial_Body(ID),
    FOREIGN KEY (Associated_Star_ID) REFERENCES Celestial_Body(ID)
);

CREATE TABLE IF NOT EXISTS Satellite (
    ID INTEGER,
    Parent_Body_ID INTEGER,
    Orbit_Period FLOAT,
    Distance_from_Parent FLOAT,
    Surface_Composition TEXT,
    Albedo FLOAT,

    FOREIGN KEY (ID) REFERENCES Celestial_Body(ID),
    FOREIGN KEY (Parent_Body_ID) REFERENCES Celestial_Body(ID)
);

CREATE TABLE IF NOT EXISTS Discoverer (
    ID INTEGER PRIMARY KEY,
    [Name] VARCHAR(255) NOT NULL,
    [Description] TEXT
);

CREATE TABLE IF NOT EXISTS Discovered_by (
    ID_Discoverer INTEGER,
    ID_CelestialBody INTEGER,

    PRIMARY KEY (ID_Discoverer, ID_CelestialBody),
    FOREIGN KEY (ID_Discoverer) REFERENCES Discoverer(ID),
    FOREIGN KEY (ID_CelestialBody) REFERENCES Celestial_Body(ID)
);

CREATE TABLE IF NOT EXISTS Institute (
    ID INTEGER PRIMARY KEY,
    [Name] VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Works_on (
    ID_Person INTEGER,
    ID_Institute INTEGER,
    
    PRIMARY KEY (ID_Person, ID_Institute),
    FOREIGN KEY (ID_Person) REFERENCES Discoverer(ID),
    FOREIGN KEY (ID_Institute) REFERENCES Institute(ID)
);

CREATE TABLE IF NOT EXISTS Planetary_System (
    System_ID INTEGER PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Discovery_Date DATE
);
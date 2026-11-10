USE AdventureWorks2022;
GO

CREATE TABLE dbo.SecurityMap (
    UserEmail NVARCHAR(100) NOT NULL,
    Region    NVARCHAR(50)  NOT NULL
);

INSERT INTO dbo.SecurityMap (UserEmail, Region) VALUES
('manager.northwest@yourdomain.com', 'Northwest'),
('manager.northeast@yourdomain.com', 'Northeast'),
('manager.central@yourdomain.com',   'Central'),
('manager.southwest@yourdomain.com', 'Southwest'),
('manager.southeast@yourdomain.com', 'Southeast'),
('manager.canada@yourdomain.com',    'Canada'),
('manager.france@yourdomain.com',    'France'),
('manager.germany@yourdomain.com',   'Germany'),
('manager.australia@yourdomain.com', 'Australia'),
('manager.uk@yourdomain.com',        'United Kingdom'),
('your.real.email@gmail.com',        'Northwest'),
('your.real.email@gmail.com',        'Canada');   -- one user, two regions

SELECT * FROM dbo.SecurityMap;
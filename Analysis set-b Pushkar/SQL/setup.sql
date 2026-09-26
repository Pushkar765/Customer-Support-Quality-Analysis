CREATE TABLE teams (
    team_id VARCHAR(10),
    team VARCHAR(50),
    department VARCHAR(50)
);

INSERT INTO teams (team_id, team, department)
VALUES
('T1', 'AccountCare', 'Service'),
('T2', 'BillingHelp', 'Service'),
('T3', 'AppSupport', 'Technical'),
('T4', 'DeviceHelp', 'Technical');

CREATE TABLE tickets (
    ticket_id INT,
    month VARCHAR(10),
    team_id VARCHAR(10),
    channel VARCHAR(20),
    resolution_hours INT,
    satisfaction INT
);

INSERT INTO tickets
(ticket_id, month, team_id, channel, resolution_hours, satisfaction)
VALUES
(1, 'Jan', 'T1', 'Email', 12, 4),
(2, 'Jan', 'T2', 'Chat', 28, 3),
(3, 'Jan', 'T3', 'Phone', 36, 2),
(4, 'Jan', 'T4', 'Email', 20, 4),
(5, 'Feb', 'T1', 'Chat', 8, 5),
(6, 'Feb', 'T2', 'Phone', 30, 3),
(7, 'Feb', 'T3', 'Email', 18, 4),
(8, 'Feb', 'T4', 'Chat', 40, 2),
(9, 'Mar', 'T1', 'Phone', 16, 4),
(10, 'Mar', 'T2', 'Email', 22, 4),
(11, 'Mar', 'T3', 'Chat', 32, 3),
(12, 'Mar', 'T4', 'Phone', 24, 5),
(12, 'Mar', 'T4', 'Phone', 24, 5);

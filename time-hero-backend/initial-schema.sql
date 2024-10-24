-- Enum table for CompletionType
CREATE TABLE CompletionTypeEnum (
    value TEXT PRIMARY KEY
);

-- CompletionTypeEnum
INSERT INTO CompletionTypeEnum (value) VALUES ('timer');
INSERT INTO CompletionTypeEnum (value) VALUES ('counter');
INSERT INTO CompletionTypeEnum (value) VALUES ('self verified');

-- Leaderboard schema
CREATE TABLE Leaderboard (
    id TEXT PRIMARY KEY, -- GUID 
    joinCode TEXT NOT NULL UNIQUE -- 6 digit alphanumeric code
);

-- User schema
CREATE TABLE User (
    id TEXT PRIMARY KEY, -- GUID
    leaderboardID TEXT, 
    accumulatedTime INTEGER NOT NULL DEFAULT 0, 
    completedTaskIDs TEXT, -- Store GUIDs of completed tasks as a JSON array of strings
    FOREIGN KEY (leaderboardID) REFERENCES Leaderboard(id)
);

-- Task schema
CREATE TABLE Task (
    id TEXT PRIMARY KEY, -- GUID 
    time INTEGER, -- Time in seconds, nullable
    metric INTEGER, -- Metric value, nullable
    completionType TEXT, -- Link to the enum type
    label TEXT NOT NULL, -- Task label
    FOREIGN KEY (completionType) REFERENCES CompletionTypeEnum(value)
);

CREATE INDEX idx_user_leaderboardID ON User (leaderboardID);
CREATE INDEX idx_user_accumulatedTime ON User (accumulatedTime);
CREATE INDEX idx_task_completionType ON Task (completionType);

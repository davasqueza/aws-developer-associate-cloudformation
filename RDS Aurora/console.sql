create table mytable (
    name       VARCHAR(20) null,
    first_name VARCHAR(20) null
);

INSERT INTO mydb.mytable(name, first_name) VALUES ('Diego', 'Vasquez');

SELECT * FROM mydb.mytable;

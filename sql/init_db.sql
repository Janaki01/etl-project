DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    id SERIAL PRIMARY KEY,
    region TEXT,
    category TEXT,
    revenue INTEGER
);

INSERT INTO sales (region, category, revenue) VALUES
('North', 'Electronics', 12000),
('North', 'Furniture', 8000),
('South', 'Electronics', 15000),
('South', 'Furniture', 8500),
('East', 'Electronics', 64000),
('East', 'Furniture', 23000),
('West', 'Electronics', 9800),
('West', 'Furniture', 5000);
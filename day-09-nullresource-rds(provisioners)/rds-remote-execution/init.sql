USE mydatabase;

-- Departments table
CREATE TABLE IF NOT EXISTS departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    department_code VARCHAR(20) NOT NULL UNIQUE,
    department_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Employees table
CREATE TABLE IF NOT EXISTS employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_code VARCHAR(20) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    salary DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    department_id INT,
    joined_at DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (department_id)
        REFERENCES departments(id)
        ON DELETE SET NULL
);

-- Projects table
CREATE TABLE IF NOT EXISTS projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    project_code VARCHAR(20) NOT NULL UNIQUE,
    project_name VARCHAR(150) NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'planned',
    start_date DATE,
    end_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Many-to-many relationship between employees and projects
CREATE TABLE IF NOT EXISTS employee_projects (
    employee_id INT NOT NULL,
    project_id INT NOT NULL,
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    role_on_project VARCHAR(100),

    PRIMARY KEY (employee_id, project_id),

    FOREIGN KEY (employee_id)
        REFERENCES employees(id)
        ON DELETE CASCADE,

    FOREIGN KEY (project_id)
        REFERENCES projects(id)
        ON DELETE CASCADE
);

-- Seed departments
INSERT IGNORE INTO departments (
    department_code,
    department_name
) VALUES
    ('ENG', 'Engineering'),
    ('OPS', 'Cloud Operations'),
    ('HR', 'Human Resources');

-- Seed employees
INSERT IGNORE INTO employees (
    employee_code,
    first_name,
    last_name,
    email,
    salary,
    department_id,
    joined_at
)
SELECT
    'EMP-1001',
    'Ayaan',
    'Khan',
    'ayaan@example.com',
    65000.00,
    id,
    '2026-01-10'
FROM departments
WHERE department_code = 'ENG';

INSERT IGNORE INTO employees (
    employee_code,
    first_name,
    last_name,
    email,
    salary,
    department_id,
    joined_at
)
SELECT
    'EMP-1002',
    'Sara',
    'Ahmed',
    'sara@example.com',
    70000.00,
    id,
    '2026-02-15'
FROM departments
WHERE department_code = 'OPS';

-- Seed projects
INSERT IGNORE INTO projects (
    project_code,
    project_name,
    status,
    start_date,
    end_date
) VALUES
    (
        'PRJ-001',
        'AWS Infrastructure Automation',
        'active',
        '2026-06-01',
        '2026-12-31'
    ),
    (
        'PRJ-002',
        'Database Migration',
        'planned',
        '2026-08-01',
        '2026-11-30'
    );

-- Assign employee to project
INSERT IGNORE INTO employee_projects (
    employee_id,
    project_id,
    role_on_project
)
SELECT
    e.id,
    p.id,
    'Terraform Engineer'
FROM employees e
JOIN projects p
    ON p.project_code = 'PRJ-001'
WHERE e.employee_code = 'EMP-1001';

-- Create a verification table
CREATE TABLE IF NOT EXISTS terraform_execution_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    execution_source VARCHAR(100) NOT NULL,
    message VARCHAR(255) NOT NULL,
    executed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add a record proving that the Terraform script ran
INSERT INTO terraform_execution_log (
    execution_source,
    message
) VALUES (
    'EC2 remote-exec provisioner',
    'Database initialization completed successfully'
);
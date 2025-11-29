-- =========================================================
-- Healthcare Visits & Vouchers – Analysis Queries
-- Schema: healthcare_project
-- =========================================================

USE healthcare_project;

-- =========================================================
-- Q1. Base visit detail (patients + clinics + conditions)
--    → One row per visit with joined info
-- =========================================================

SELECT
    v.visit_id,
    v.visit_date,
    p.patient_id,
    p.first_name,
    p.last_name,
    c.clinic_id,
    c.clinic_name       AS clinic_name,
    c.type              AS clinic_type,
    v.total_bill,
    v.amount_paid,
    v.amount_due,
    GROUP_CONCAT(DISTINCT m.condition_name ORDER BY m.condition_name) AS conditions_seen
FROM visit v
JOIN patients p
    ON v.patient_id = p.patient_id
JOIN clinic c
    ON v.clinic_id = c.clinic_id
LEFT JOIN visit_condition vc
    ON v.visit_id = vc.visit_id
LEFT JOIN medical_condition m
    ON vc.condition_id = m.condition_id
GROUP BY
    v.visit_id,
    v.visit_date,
    p.patient_id,
    p.first_name,
    p.last_name,
    c.clinic_id,
    c.clinic_name,
    c.type,
    v.total_bill,
    v.amount_paid,
    v.amount_due
ORDER BY v.visit_date DESC
LIMIT 50;


-- =========================================================
-- Q2. Monthly revenue & visit volume
--    → How much do we earn per month, and how many visits?
-- =========================================================

SELECT
    DATE_FORMAT(v.visit_date, '%Y-%m') AS year_and_month,
    SUM(v.total_bill)                  AS total_revenue,
    COUNT(*)                           AS visit_count
FROM visit v
GROUP BY year_and_month
ORDER BY year_and_month;


-- =========================================================
-- Q3. Clinic type cost comparison
--    → Which clinic types are most expensive?
-- =========================================================

SELECT
    c.type                              AS clinic_type,
    COUNT(*)                            AS visit_count,
    AVG(v.total_bill)                   AS avg_total_bill,
    AVG(v.amount_due)                   AS avg_amount_due
FROM visit v
JOIN clinic c
    ON v.clinic_id = c.clinic_id
GROUP BY c.type
ORDER BY avg_total_bill DESC;


-- =========================================================
-- Q4. Visits with multiple diagnoses
--    → How many conditions were recorded per visit?
-- =========================================================

SELECT
    v.visit_id,
    v.visit_date,
    p.patient_id,
    p.first_name,
    p.last_name,
    COUNT(vc.condition_id) AS condition_count
FROM visit v
JOIN patients p
    ON v.patient_id = p.patient_id
JOIN visit_condition vc
    ON v.visit_id = vc.visit_id
GROUP BY
    v.visit_id,
    v.visit_date,
    p.patient_id,
    p.first_name,
    p.last_name
HAVING condition_count > 1
ORDER BY condition_count DESC, v.visit_date DESC;


-- =========================================================
-- Q5. Vouchers expiring in the next 30 days
--    → Who should we contact soon?
-- =========================================================

SELECT
    vo.voucher_id,
    vo.issue_date,
    vo.expiration_date,
    p.patient_id,
    p.first_name,
    p.last_name,
    vo.amount          AS voucher_amount
FROM voucher vo
JOIN patients p
    ON vo.patient_id = p.patient_id
WHERE vo.expiration_date BETWEEN CURDATE()
                             AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)
ORDER BY vo.expiration_date, p.last_name, p.first_name;


-- =========================================================
-- Q6. Repeat patients (3+ visits)
--    → Who are our most frequent visitors?
-- =========================================================

SELECT
    p.patient_id,
    p.first_name,
    p.last_name,
    COUNT(*) AS visit_count
FROM visit v
JOIN patients p
    ON v.patient_id = p.patient_id
GROUP BY
    p.patient_id,
    p.first_name,
    p.last_name
HAVING visit_count >= 3
ORDER BY visit_count DESC, p.last_name, p.first_name;


-- =========================================================
-- Q7. Visits by age band and gender
--    → Which groups use our services the most?
-- =========================================================

SELECT
    CASE
        WHEN TIMESTAMPDIFF(YEAR, p.dob, v.visit_date) < 18 THEN '0-17'
        WHEN TIMESTAMPDIFF(YEAR, p.dob, v.visit_date) < 35 THEN '18-34'
        WHEN TIMESTAMPDIFF(YEAR, p.dob, v.visit_date) < 50 THEN '35-49'
        WHEN TIMESTAMPDIFF(YEAR, p.dob, v.visit_date) < 65 THEN '50-64'
        ELSE '65+'
    END AS age_band,
    p.gender,
    COUNT(*) AS visit_count
FROM visit v
JOIN patients p
    ON v.patient_id = p.patient_id
GROUP BY age_band, p.gender
ORDER BY
    FIELD(age_band, '0-17', '18-34', '35-49', '50-64', '65+'),
    p.gender;


-- =========================================================
-- Q8. Top medical conditions
--    → What issues are patients coming in for most often?
-- =========================================================

SELECT
    m.condition_name,
    COUNT(*) AS visit_count
FROM visit_condition vc
JOIN medical_condition m
    ON vc.condition_id = m.condition_id
GROUP BY m.condition_id, m.condition_name
ORDER BY visit_count DESC
LIMIT 10;
-- Employee Leave Management: BA-focused SQL analysis
-- SQLite-compatible queries using the synthetic case-study data.
-- The goal is practical, explainable SQL rather than advanced SQL development.

-- 1. What is the request distribution by status?
SELECT Status, COUNT(*) AS RequestCount
FROM LeaveRequests
GROUP BY Status
ORDER BY RequestCount DESC;

-- 2. Which departments generate the most leave activity?
SELECT e.Department,
       COUNT(lr.LeaveRequestID) AS TotalRequests,
       SUM(lr.RequestedDays) AS TotalRequestedDays
FROM Employees e
INNER JOIN LeaveRequests lr ON e.EmployeeID = lr.EmployeeID
GROUP BY e.Department
ORDER BY TotalRequests DESC;

-- 3. Which employees have no leave requests?
SELECT e.EmployeeID, e.EmployeeName, e.Department
FROM Employees e
LEFT JOIN LeaveRequests lr ON e.EmployeeID = lr.EmployeeID
WHERE lr.LeaveRequestID IS NULL
ORDER BY e.EmployeeID;

-- 4. Which departments have more than 20 requests?
SELECT e.Department, COUNT(*) AS RequestCount
FROM Employees e
INNER JOIN LeaveRequests lr ON e.EmployeeID = lr.EmployeeID
GROUP BY e.Department
HAVING COUNT(*) > 20
ORDER BY RequestCount DESC;

-- 5. Which departments exist in the employee master?
SELECT DISTINCT Department
FROM Employees
ORDER BY Department;

-- 6. What is the average, minimum and maximum remaining leave balance?
SELECT ROUND(AVG(RemainingBalanceDays), 2) AS AvgRemainingBalance,
       MIN(RemainingBalanceDays) AS MinRemainingBalance,
       MAX(RemainingBalanceDays) AS MaxRemainingBalance
FROM LeaveBalances;

-- 7. How can remaining balances be classified for review?
SELECT e.EmployeeID, e.EmployeeName, e.Department,
       lb.RemainingBalanceDays,
       CASE
         WHEN lb.RemainingBalanceDays = 0 THEN 'No Balance'
         WHEN lb.RemainingBalanceDays <= 5 THEN 'Low Balance'
         WHEN lb.RemainingBalanceDays <= 10 THEN 'Moderate Balance'
         ELSE 'Healthy Balance'
       END AS BalanceCategory
FROM Employees e
INNER JOIN LeaveBalances lb ON e.EmployeeID = lb.EmployeeID
ORDER BY e.EmployeeID;

-- 8. Which requests are still pending and may require follow-up?
SELECT e.EmployeeID, e.EmployeeName, e.Department,
       lr.LeaveRequestID, lr.RequestDate, lr.RequestedDays
FROM Employees e
INNER JOIN LeaveRequests lr ON e.EmployeeID = lr.EmployeeID
WHERE lr.Status = 'Pending'
ORDER BY lr.RequestDate;

-- 9. Which leave types account for the most approved leave?
SELECT lt.LeaveType,
       COUNT(lr.LeaveRequestID) AS ApprovedRequests,
       SUM(lr.RequestedDays) AS ApprovedDays
FROM LeaveTypes lt
INNER JOIN LeaveRequests lr ON lt.LeaveTypeID = lr.LeaveTypeID
WHERE lr.Status = 'Approved'
GROUP BY lt.LeaveType
ORDER BY ApprovedDays DESC;

-- 10. Are there leave-balance exceptions that need investigation?
SELECT e.EmployeeID, e.EmployeeName, e.Department,
       lb.AnnualEntitlementDays, lb.ApprovedDaysUsed,
       lb.RemainingBalanceDays
FROM Employees e
INNER JOIN LeaveBalances lb ON e.EmployeeID = lb.EmployeeID
WHERE lb.ApprovedDaysUsed > lb.AnnualEntitlementDays
   OR lb.RemainingBalanceDays < 0
ORDER BY lb.ApprovedDaysUsed DESC;

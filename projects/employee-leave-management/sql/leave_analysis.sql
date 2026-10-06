-- Employee Leave Management: BA-focused SQL analysis
-- SQLite-compatible queries. Each query answers a practical business question.

-- 1. What is the request distribution by status?
SELECT Status, COUNT(*) AS RequestCount
FROM LeaveRequests
GROUP BY Status
ORDER BY RequestCount DESC;

-- 2. Which departments generate the most leave activity? (INNER JOIN)
SELECT e.Department,
       COUNT(lr.LeaveRequestID) AS TotalRequests,
       SUM(lr.RequestedDays) AS TotalRequestedDays
FROM Employees e
INNER JOIN LeaveRequests lr ON e.EmployeeID = lr.EmployeeID
GROUP BY e.Department
ORDER BY TotalRequests DESC;

-- 3. Which employees have no leave requests? (LEFT JOIN + IS NULL)
SELECT e.EmployeeID, e.EmployeeName, e.Department
FROM Employees e
LEFT JOIN LeaveRequests lr ON e.EmployeeID = lr.EmployeeID
WHERE lr.LeaveRequestID IS NULL
ORDER BY e.EmployeeID;

-- 4. Which departments have more than 20 requests? (GROUP BY + HAVING)
SELECT e.Department, COUNT(*) AS RequestCount
FROM Employees e
INNER JOIN LeaveRequests lr ON e.EmployeeID = lr.EmployeeID
GROUP BY e.Department
HAVING COUNT(*) > 20
ORDER BY RequestCount DESC;

-- 5. Which approved Vacation or Sick requests are longer than 3 days? (WHERE + AND + IN)
SELECT lr.LeaveRequestID, e.EmployeeName, e.Department,
       lt.LeaveType, lr.RequestedDays
FROM LeaveRequests lr
INNER JOIN Employees e ON lr.EmployeeID = e.EmployeeID
INNER JOIN LeaveTypes lt ON lr.LeaveTypeID = lt.LeaveTypeID
WHERE lr.Status = 'Approved'
  AND lt.LeaveType IN ('Vacation', 'Sick')
  AND lr.RequestedDays > 3
ORDER BY lr.RequestedDays DESC;

-- 6. Which departments appear in the employee master? (DISTINCT)
SELECT DISTINCT Department
FROM Employees
ORDER BY Department;

-- 7. What is the average, minimum and maximum remaining leave balance?
SELECT ROUND(AVG(RemainingBalanceDays), 2) AS AvgRemainingBalance,
       MIN(RemainingBalanceDays) AS MinRemainingBalance,
       MAX(RemainingBalanceDays) AS MaxRemainingBalance
FROM LeaveBalances;

-- 8. How can remaining balances be grouped for review? (CASE)
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
ORDER BY lb.RemainingBalanceDays, e.EmployeeID;

-- 9. Which requests are still pending and may require follow-up?
SELECT e.EmployeeID, e.EmployeeName, e.Department,
       lr.LeaveRequestID, lr.RequestDate, lr.RequestedDays
FROM Employees e
INNER JOIN LeaveRequests lr ON e.EmployeeID = lr.EmployeeID
WHERE lr.Status = 'Pending'
ORDER BY lr.RequestDate;

-- 10. Which leave types account for the most approved leave?
SELECT lt.LeaveType,
       COUNT(lr.LeaveRequestID) AS ApprovedRequests,
       SUM(lr.RequestedDays) AS ApprovedDays
FROM LeaveTypes lt
INNER JOIN LeaveRequests lr ON lt.LeaveTypeID = lr.LeaveTypeID
WHERE lr.Status = 'Approved'
GROUP BY lt.LeaveType
ORDER BY ApprovedDays DESC;

-- 11. How does request volume change by month? (date function)
SELECT strftime('%Y-%m', RequestDate) AS RequestMonth,
       COUNT(*) AS RequestCount,
       SUM(RequestedDays) AS RequestedDays
FROM LeaveRequests
GROUP BY strftime('%Y-%m', RequestDate)
ORDER BY RequestMonth;

-- 12. Are there leave-balance exceptions that need investigation?
SELECT e.EmployeeID, e.EmployeeName, e.Department,
       lb.AnnualEntitlementDays, lb.ApprovedDaysUsed,
       lb.RemainingBalanceDays
FROM Employees e
INNER JOIN LeaveBalances lb ON e.EmployeeID = lb.EmployeeID
WHERE lb.ApprovedDaysUsed > lb.AnnualEntitlementDays
   OR lb.RemainingBalanceDays < 0
ORDER BY lb.ApprovedDaysUsed DESC;

-- 13. Which employees have below-average remaining leave balance? (subquery)
SELECT e.EmployeeID, e.EmployeeName, e.Department,
       lb.RemainingBalanceDays
FROM Employees e
INNER JOIN LeaveBalances lb ON e.EmployeeID = lb.EmployeeID
WHERE lb.RemainingBalanceDays < (
    SELECT AVG(RemainingBalanceDays)
    FROM LeaveBalances
)
ORDER BY lb.RemainingBalanceDays;

-- 14. Which employees currently have a pending request? (IN subquery)
SELECT EmployeeID, EmployeeName, Department
FROM Employees
WHERE EmployeeID IN (
    SELECT EmployeeID
    FROM LeaveRequests
    WHERE Status = 'Pending'
)
ORDER BY EmployeeID;

-- 15. Show approval information with a readable fallback for missing dates. (COALESCE)
SELECT LeaveRequestID, EmployeeID, Status,
       COALESCE(NULLIF(ApprovalDate, ''), 'Not yet approved') AS ApprovalStatusDate
FROM LeaveRequests
ORDER BY LeaveRequestID;

-- 16. Which departments account for the most approved Vacation days? (3-table business investigation)
SELECT e.Department,
       COUNT(lr.LeaveRequestID) AS ApprovedVacationRequests,
       SUM(lr.RequestedDays) AS ApprovedVacationDays
FROM Employees e
INNER JOIN LeaveRequests lr ON e.EmployeeID = lr.EmployeeID
INNER JOIN LeaveTypes lt ON lr.LeaveTypeID = lt.LeaveTypeID
WHERE lr.Status = 'Approved'
  AND lt.LeaveType = 'Vacation'
GROUP BY e.Department
ORDER BY ApprovedVacationDays DESC;

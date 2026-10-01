-- Employee Leave Management: practical SQL analysis
-- SQLite-compatible queries answering business questions.

-- 1. Request status distribution
SELECT Status, COUNT(*) AS RequestCount
FROM LeaveRequests
GROUP BY Status
ORDER BY RequestCount DESC;

-- 2. Leave activity by department
SELECT e.Department,
       COUNT(lr.LeaveRequestID) AS TotalRequests,
       SUM(lr.RequestedDays) AS TotalRequestedDays
FROM Employees e
JOIN LeaveRequests lr ON e.EmployeeID = lr.EmployeeID
GROUP BY e.Department
ORDER BY TotalRequests DESC;

-- 3. Employees with no leave requests
SELECT e.EmployeeID, e.EmployeeName, e.Department
FROM Employees e
LEFT JOIN LeaveRequests lr ON e.EmployeeID = lr.EmployeeID
WHERE lr.LeaveRequestID IS NULL
ORDER BY e.EmployeeID;

-- 4. Employees with more than two requests
SELECT e.EmployeeID, e.EmployeeName, e.Department,
       COUNT(lr.LeaveRequestID) AS RequestCount
FROM Employees e
JOIN LeaveRequests lr ON e.EmployeeID = lr.EmployeeID
GROUP BY e.EmployeeID, e.EmployeeName, e.Department
HAVING COUNT(lr.LeaveRequestID) > 2
ORDER BY RequestCount DESC;

-- 5. Leave balance categories
SELECT e.EmployeeID, e.EmployeeName, e.Department,
       lb.RemainingBalanceDays,
       CASE
         WHEN lb.RemainingBalanceDays = 0 THEN 'No Balance'
         WHEN lb.RemainingBalanceDays <= 5 THEN 'Low Balance'
         WHEN lb.RemainingBalanceDays <= 10 THEN 'Moderate Balance'
         ELSE 'Healthy Balance'
       END AS BalanceCategory
FROM Employees e
JOIN LeaveBalances lb ON e.EmployeeID = lb.EmployeeID
ORDER BY lb.RemainingBalanceDays, e.EmployeeID;

-- 6. Pending requests requiring follow-up
SELECT e.EmployeeID, e.EmployeeName, e.Department,
       lr.LeaveRequestID, lr.RequestDate, lr.LeaveStartDate,
       lr.LeaveEndDate, lr.RequestedDays
FROM Employees e
JOIN LeaveRequests lr ON e.EmployeeID = lr.EmployeeID
WHERE lr.Status = 'Pending'
ORDER BY lr.RequestDate;

-- 7. Approved leave by type
SELECT lt.LeaveType,
       COUNT(lr.LeaveRequestID) AS ApprovedRequests,
       SUM(lr.RequestedDays) AS ApprovedDays
FROM LeaveTypes lt
JOIN LeaveRequests lr ON lt.LeaveTypeID = lr.LeaveTypeID
WHERE lr.Status = 'Approved'
GROUP BY lt.LeaveType
ORDER BY ApprovedDays DESC;

-- 8. Monthly request trend
SELECT strftime('%Y-%m', RequestDate) AS RequestMonth,
       COUNT(*) AS RequestCount,
       SUM(RequestedDays) AS RequestedDays
FROM LeaveRequests
GROUP BY strftime('%Y-%m', RequestDate)
ORDER BY RequestMonth;

-- 9. Business-rule / data-quality exception check
SELECT e.EmployeeID, e.EmployeeName, e.Department,
       lb.AnnualEntitlementDays, lb.ApprovedDaysUsed,
       lb.RemainingBalanceDays
FROM Employees e
JOIN LeaveBalances lb ON e.EmployeeID = lb.EmployeeID
WHERE lb.ApprovedDaysUsed > lb.AnnualEntitlementDays
ORDER BY lb.ApprovedDaysUsed DESC;

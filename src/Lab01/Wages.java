package Lab01;

import java.lang.reflect.Constructor;
import java.util.ArrayList;
import java.util.List;

abstract class Employee
{
    String name;

    Employee()
    {
    }

    Employee(String nm)
    {
        name = nm;
    }

    abstract double computePay();

    void display()
    {
    }

    void setHours(double hrs)
    {
    }

    void setSales(double sales)
    {
    }

    void setSalary(double salary)
    {
        System.out.println("NO!");
    }
}

class WageEmployee extends Employee
{
    double rate;
    double hours;

    WageEmployee(String nm)
    {
        super(nm);
    }

    WageEmployee(String nm, double r)
    {
        super(nm);
        rate = r;
    }

    void setRate(double r)
    {
        rate = r;
    }

    void setHours(double hrs)
    {
        hours = hrs;
    }

    double computePay()
    {
        return rate * hours;
    }
}

class Programmer extends WageEmployee
{
    Programmer(String nm, double w)
    {
        super(nm, w);
    }

    void display()
    {
        System.out.println("Name: " + name + "\tHours: " + hours + "\tRate: " + rate);
    }
}

class SalesPerson extends WageEmployee
{
    double commission;
    double SalesMade;

    SalesPerson(String nm, double c)
    {
        super(nm);
        commission = c;
    }

    void setCommission(double comm)
    {
        commission = comm;
    }

    void setSales(double sales)
    {
        SalesMade = sales;
    }

    double computePay()
    {
        return commission * SalesMade;
    }

    void display()
    {
        System.out.println("Name: " + name + "\tCommission: " + commission + "\tSales: " + SalesMade);
    }
}

class Manager extends Employee
{
    double monthlysalary;

    Manager()
    {
        super("");
    }

    Manager(String nm, double w)
    {
        super(nm);
        monthlysalary = w;
    }

    void setSalary(double salary)
    {
        monthlysalary = salary;
    }

    double computePay()
    {
        return monthlysalary;
    }

    void display()
    {
        System.out.println("Name: " + name + "\tMonthly Salary: " + monthlysalary);
    }
}

interface ManagerInterface
{
    double managerComputePay();

    void managerDisplay();
}

class SalesManager extends SalesPerson implements ManagerInterface
{
    double monthlysalary;

    SalesManager(String nm, double w)
    {
        super(nm, w);
    }

    public double managerComputePay()
    {
        return monthlysalary;
    }

    double computePay()
    {
        System.out.println("SalesManager: " + name + " " + super.computePay() + managerComputePay());
        return super.computePay() + managerComputePay();
    }

    void setSalary(double s)
    {
        monthlysalary = s;
    }

    public void managerDisplay()
    {
        System.out.println("Name: " + name + "\tMonthly Salary: " + monthlysalary);
    }

    void display()
    {
        super.display();
        managerDisplay();
    }
}

class EmployeeList
{
    List<Employee> _employeList;
    EmployeeList()
    {
        _employeList = new ArrayList<Employee>();
    }

    Employee find(String name)
    {
        for (Employee employee: _employeList)
        {
            if(name.equals(employee.name)) return employee;
        }
        return null;
    }

    void setHours(String name, double hours)
    {
        Employee emp = find(name);
        if(emp != null)
        {
            emp.setHours(hours);
        }
    }

    void setSalary(String name, double salary)
    {
        Employee emp = find(name);
        if(emp != null)
        {
            emp.setSalary(salary);
        }
    }

    void setSales(String name, double sales)
    {
        Employee emp = find(name);
        if(emp != null)
        {
            emp.setSales(sales);
        }
    }

    void enqueue(Employee employee)
    {
        _employeList.add(employee);
    }

    void display()
    {
        for (Employee emp: _employeList)
        {
            emp.display();
        }
    }

    double payroll()
    {
        double pay = 0;
        for (Employee emp: _employeList)
        {
            pay += emp.computePay();
        }
        return pay;
    }
}

public class Wages
{
    public static void main(String argv[])
    {
        EmployeeList emp = new EmployeeList();
        emp.enqueue(new SalesManager("Gee", 1000));
        emp.enqueue(new SalesManager("Gal", 1000));
        emp.enqueue(new SalesManager("Gem", 1000));
        emp.enqueue(new SalesPerson("John", 0.03));
        emp.enqueue(new SalesPerson("Joan", 0.04));
        emp.enqueue(new SalesPerson("Jack", 0.02));
        emp.enqueue(new Manager("Fred", 10000));
        emp.enqueue(new Manager("Frank", 5000));
        emp.enqueue(new Manager("Florence", 3000));
        emp.enqueue(new Programmer("Linda", 7));
        emp.enqueue(new Programmer("Larry", 5));
        emp.enqueue(new Programmer("Lewis", 3));

        emp.setHours("Linda", 35);
        emp.setHours("Larry", 23);
        emp.setHours("Lewis", 3);
        emp.setSales("John", 12000);
        emp.setSales("Joan", 10000);
        emp.setSales("Jack", 5000);
        emp.setSales("Gee", 4000);
        emp.setSales("Gal", 3000);
        emp.setSales("Gem", 2000);
        emp.setSalary("Gee", 1000);
        emp.setSalary("Gal", 2000);
        emp.setSalary("Gem", 3000);
        emp.display();
        System.out.println("Payroll: " + emp.payroll());
    }
}

//    Sample Output:
//        Name: Gee       Commission: 1000.0      Sales: 4000.0
//        Name: Gee       Monthly Salary: 1000.0
//        Name: Gal       Commission: 1000.0      Sales: 3000.0
//        Name: Gal       Monthly Salary: 2000.0
//        Name: Gem       Commission: 1000.0      Sales: 2000.0
//        Name: Gem       Monthly Salary: 3000.0
//        Name: John      Commission: 0.03        Sales: 12000.0
//        Name: Joan      Commission: 0.04        Sales: 10000.0
//        Name: Jack      Commission: 0.02        Sales: 5000.0
//        Name: Fred      Monthly Salary: 10000.0
//        Name: Frank     Monthly Salary: 5000.0
//        Name: Florence  Monthly Salary: 3000.0
//        Name: Linda     Hours: 35.0     Rate: 7.0
//        Name: Larry     Hours: 23.0     Rate: 5.0
//        Name: Lewis     Hours: 3.0      Rate: 3.0
//
//        SalesManager: Gee 4001000.0
//        SalesManager: Gal 3002000.0
//        SalesManager: Gem 2003000.0
//        Payroll: 9025229.0

// import { Request, Response } from "express";
// import { Employee } from "../model/user_model";

// class EmployeeController {

//     getAllEmployee = async (request: Request, response: Response) => {
//         try {
//             const employees = await Employee.find();
//             return response.status(200).json({ data: employees });
//         } catch (error) {
//             return response.status(500).json({ error: "Server Error" });
//         }
//     }

//     createEmployee = async (request: Request, response: Response) => {
//         try {
//             const { name, email, mobile } = request.body;

//             const employee = await Employee.create({ name, email, mobile });

//             return response.status(201).json({
//                 message: "✅ Employee Created Successfully",
//                 data: employee,
//             });
//         } catch (error) {
//             return response.status(400).json({ error: "Bad Request" });
//         }
//     }

//     updateEmployee = async (request: Request, response: Response) => {
//         try {
//             const { id } = request.params;
//             const { name, email, mobile } = request.body;

//             const employee = await Employee.findById(id);

//             if (!employee) {
//                 return response.status(404).json({ error: "Employee Not Found" });
//             }

//             employee.name = name;
//             employee.email = email;
//             employee.mobile = mobile;

//             await employee.save();

//             return response.status(200).json({
//                 message: "✅ Employee Updated Successfully",
//                 data: employee,
//             });

//         } catch (error) {
//             return response.status(400).json({ error: "Bad Request" });
//         }
//     }

//     deleteEmployee = async (request: Request, response: Response) => {
//         try {
//             const { id } = request.params;

//             const employee = await Employee.findByIdAndDelete(id);

//             if (!employee) {
//                 return response.status(404).json({ error: "Employee Not Found" });
//             }

//             return response.status(200).json({
//                 message: "🗑️ Employee Deleted Successfully",
//                 data: employee,
//             });

//         } catch (error) {
//             return response.status(500).json({ error: "Server Error" });
//         }
//     }

// }

// export default new EmployeeController();

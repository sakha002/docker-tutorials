import grpc 
import mip_pb2
import mip_pb2_grpc
import linear_solver_pb2



def create_model_request(model_request):
    model = model_request.model

    objective_coefficients = [10.0, 6.0, 4.0]
    variable_names = ["x1", "x2", "x3"]
    constraint_names = ["c1", "c2", "c3"]
    constraint_upbound = [100.0, 600.0, 300.0]
    constraint_coefficients = [[1.0, 1.0, 1.0], [10.0, 4.0, 5.0], [2.0, 2.0, 6.0]]

    # Set up variables
    num_var = len(variable_names)
    for i in range(num_var):
        variable = model.variable.add()
        variable.name = variable_names[i]
        variable.objective_coefficient = objective_coefficients[i]
        variable.lower_bound = 0.0 
        variable.is_integer = False  

    model.maximize = True

    # Set up constraints
    num_cons = len(constraint_names)
    for i in range(num_cons):
        constraint = model.constraint.add()
        constraint.name = constraint_names[i]
        constraint.upper_bound = constraint_upbound[i]
        # dealing with the constraint coefficient 
        for j in range(num_var):
            constraint.coefficient.append(constraint_coefficients[i][j])
            constraint.var_index.append(j)
    # Set up solver 
    model_request.solver_type  = linear_solver_pb2.MPModelRequest.SolverType.GLOP_LINEAR_PROGRAMMING

    return 


def read_solution(model_solution):
    print("The values of the variables:")
    variable_names = ["x1", "x2", "x3"]
    for j in range(3):
        print('Variable %s : %f' %(variable_names[j], model_solution.variable_value[j]))
    print("The objective value : %f" %(model_solution.objective_value))
    return 




def run(model_request):
    with grpc.insecure_channel('localhost:5050') as channel:
        stub = mip_pb2_grpc.MPServiceStub(channel)
        model_solution = stub.MPModel(model_request)
    read_solution(model_solution)
    return 



if __name__ == '__main__':
    model_request = linear_solver_pb2.MPModelRequest()
    create_model_request(model_request)
    run(model_request)

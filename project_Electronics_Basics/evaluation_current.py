import syside_license
syside_license.check()  # Validates your license
import syside

model, diagnostics = syside.load_model(["/Users/alejandronietocuatenta/Documents/SysML_v2/project_Electronics_Basics/electronics_basic.sysml"])

# print("\ncheck part usage")
# for part_element in model.nodes(syside.PartUsage):
#     print(part_element)
#     print(part_element.feature_value_expression)

print("\nattribute evaluation")
for attr_element in model.nodes(syside.AttributeUsage):
    # print(attr_element.name)
    # print(attr_element.feature_value_expression)
    expression = attr_element.feature_value_expression
    result = syside.Compiler().evaluate(expression)[0]
    print(f"{attr_element.owner.name} {attr_element.name} = {result}")
print("\nDone")

    # if attr_element.name == "mass":
    #     expression = attr_element.feature_value_expression
    #     assert expression is not None
    #     evaluation = syside.Compiler().evaluate(expression)
    #     if evaluation[1].fatal:
    #         print(f"Error evaluating {attr_element.name}")
    #     else:
    #         value = evaluation[0]
    #     assert attr_element.owner is not None
    #     print(f"Mass of {attr_element.owner.name} = {value}")

# # NOT WORKING
# compiler = syside.Compiler()
# for parameter in value.owned_parameters.collect():
#     expr = parameter.feature_value_expression
#     if not expr:
#         # should not be executed in a valid model
#         print(f"{parameter} has no feature value")
#     else:
#         result, report = compiler.evaluate(expr, scope=owning_type)
#         if not report:
#             print(f"{parameter} failed to evaluate: {report.diagnostics}")
#         elif isinstance(result, str):
#             print(f'{parameter} = "{result}"')
#         else:
#             print(f"{parameter} = {result}")
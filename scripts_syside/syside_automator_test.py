import syside_license
syside_license.check()  # Validates your license

# After successful validation, you can use SysIDE:
import syside

# load model
# model, diagnostics = syside.load_model(["generic_example_RFLP/example_rflp.sysml"])
model, diagnostics = syside.load_model(["/Users/alejandronietocuatenta/Documents/SysML_v2/project_VehicleModel_AnnexB/vehicleModel_StepByStep.sysml"])

# # print all elements
# for element in model.elements(syside.PartUsage):
#     print(element.name)

# # print all elements iniside a part
# for element in model.nodes(syside.PartUsage):
#     if element.name == "vehicle_a":
#         for owned_element in element.owned_elements.collect():
#             print(owned_element.name)

# # print owner of part
# for element in model.nodes(syside.PartUsage):
#     if element.name == "vehicle_a" and element.owner is not None:
#         print(element.owner.name)

#  check part attributes
for attr_element in model.nodes(syside.AttributeUsage):
    if attr_element.name == "mass":
        expression = attr_element.feature_value_expression
        assert expression is not None
        evaluation = syside.Compiler().evaluate(expression)
        if evaluation[1].fatal:
            print(f"Error evaluating {attr_element.name}")
        else:
            value = evaluation[0]
        assert attr_element.owner is not None
        print(f"Mass of {attr_element.owner.name} = {value}")

print('Debbuging done')
import syside_license
syside_license.check()  # Validates your license

# After successful validation, you can use SysIDE:
import syside

# load model
model, diagnostics = syside.load_model(["generic_example_RFLP/example_rflp.sysml"])

# # print all elements
# for element in model.elements(syside.PartUsage):
#     print(element.name)

# # print all elements iniside a part
# for element in model.nodes(syside.PartUsage):
#     if element.name == "pcba":
#         for owned_element in element.owned_elements.collect():
#             print(owned_element.name)

# print owner of part
for element in model.nodes(syside.PartUsage):
    if element.name == "pcba" and element.owner is not None:
        print(element.owner.name)

print('Debbuging done')
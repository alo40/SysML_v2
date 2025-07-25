# import syside_license
# syside_license.check()  # Validates your license
import syside

# Load the model - this is the first step for any SysIDE Automator script
# model, diagnostics = syside.load_model(["/Users/alejandronietocuatenta/Documents/SysML_v2/syside_firstExample/example_model.sysml"])
model, diagnostics = syside.load_model(["/Users/alejandronietocuatenta/Documents/SysML_v2/generic_electronics/pcba_simulation.sysml"])
# model, diagnostic = syside.load_model(["/Users/alejandronietocuatenta/Documents/SysML_v2/syside_jsonExport/json_export_model.sysml"])

def walk_ownership_tree(element: syside.Element, level: int = 0) -> None:
    """Recursively print all elements in the model."""
    if element.name is not None:
        print("  " * level, element.name)
    else:
        print("  " * level, "anonymous element")
    # Recursive walk through child elements
    for child in element.owned_elements.collect():
        walk_ownership_tree(child, level + 1)


# Process each document in the model
for document_resource in model.documents:
    with document_resource.lock() as document:
        print("Walking the ownership tree printing all elements:")
        walk_ownership_tree(document.root_node)

def show_parts_of_type(model: syside.Model, part_type: str) -> None:
    """Display all parts of a specific type in the model."""
    for part in model.nodes(syside.PartUsage):
        for element in part.heritage.elements:
            if element.try_cast(syside.PartDefinition):
                if element.declared_name == part_type:
                    print("- ", part.name)


print("\nElectrical parts in the model:")
show_parts_of_type(model, "Electrical")

print("\nMechanical parts in the model:")
show_parts_of_type(model, "Mechanical")
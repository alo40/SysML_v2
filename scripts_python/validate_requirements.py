import syside
model, diagnostics = syside.load_model(["/Users/alejandronietocuatenta/Documents/SysML_v2/syside_firstExample/example_model_enhanced.sysml"])

def show_part_decomposition(
    element: syside.Element, part_level: int = 0
) -> None:
    """Display a clean part decomposition tree."""
    if element.try_cast(syside.PartUsage):
        print("  " * part_level, element.name)
        new_part_level = part_level + 1
    else:
        new_part_level = part_level
    for child in element.owned_elements.collect():
        show_part_decomposition(child, new_part_level)


# Find total mass and mass requirement:
for attribute in model.nodes(syside.AttributeUsage):
    if attribute.name == "MassActual":
        assert attribute.feature_value_expression is not None
        evaluation = syside.Compiler().evaluate(
            attribute.feature_value_expression
        )
        if evaluation[1].fatal:
            print(f"Error evaluating {attribute.name}")
        else:
            total_mass = evaluation[0]
    if attribute.name == "MassLimit":
        assert attribute.feature_value_expression is not None
        evaluation = syside.Compiler().evaluate(
            attribute.feature_value_expression
        )
        if evaluation[1].fatal:
            print(f"Error evaluating {attribute.name}")
        else:
            mass_limit = evaluation[0]

# Display results
print("\nPart decomposition:")
for doc in model.user_docs:
    with doc.lock() as locked:
        show_part_decomposition(locked.root_node)

print(f"\nTotal mass: {total_mass} kg")
if isinstance(total_mass, (int, float)) and isinstance(
    mass_limit, (int, float)
):
    if total_mass <= mass_limit:
        print("✓ Mass requirement met")
    else:
        print("✗ Mass requirement not met")
else:
    print("✗ Cannot compare mass values - invalid types")
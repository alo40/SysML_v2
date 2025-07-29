import pathlib
import syside

EXAMPLE_DIR = pathlib.Path(__file__).parent
MODEL_FILE_PATH = EXAMPLE_DIR / "example_model_3.sysml"
# The deserialized model will be stored in a document with MODEL_PATH path.
# The MODEL_PATH does not necessarily need to exist on the local file system.
MODEL_PATH = "file://" + str(MODEL_FILE_PATH)


def walk_ownership_tree(element: syside.Element, level: int = 0) -> None:
    """
    Prints out all elements in a model in a tree-like format, where
    child elements appear indented under their parent elements. For
    example:

    Parent
      Child1
      Child2
        Grandchild

    Args:
        element: The model element to start printing from
        level: How many levels to indent (increases for nested elements)
    """
    if element.name is not None:
        print("  " * level, element.name)
    else:
        print("  " * level, "anonymous element")
    # Recursively call walk_ownership_tree() for each owned element
    # (child element).
    element.owned_elements.for_each(
        lambda owned_element: walk_ownership_tree(owned_element, level + 1)
    )


def main() -> None:
    with open("generic_electronics/output.json", "r") as f:
        json_import = f.read()
    deserialized_model, _ = syside.json.loads(json_import, MODEL_PATH)

    walk_ownership_tree(deserialized_model.document.root_node)


if __name__ == "__main__":
    main()
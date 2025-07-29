import pathlib
import syside

EXAMPLE_DIR = pathlib.Path(__file__).parent.parent
# MODEL_FILE_PATH = EXAMPLE_DIR / "generic_electronics/pcba_simulation.sysml"
MODEL_FILE_PATH = EXAMPLE_DIR / "syside_classNames/classNames.sysml"


def main() -> None:
    (
        model,
        diagnostics,
    ) = syside.load_model(paths=[MODEL_FILE_PATH])

    # Only errors cause an exception. SysIDE may also report warnings and
    # informational messages, but not for this example.
    assert not diagnostics.contains_errors(warnings_as_errors=True)

    for doc in model.user_docs:
        # Since SysIDE is a multi-threaded application, we need to lock the
        # document to ensure that the document is not modified from another
        # thread while we are accessing it.
        with doc.lock() as locked:
            print("Model sexp:")
            print(syside.sexp(locked.root_node))


if __name__ == "__main__":
    main()
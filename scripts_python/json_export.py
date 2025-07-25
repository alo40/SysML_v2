import pathlib
import syside
import json
import codecs


EXAMPLE_DIR = pathlib.Path(__file__).parent.parent

# syside example
MODEL_DIR_PATH = EXAMPLE_DIR / "syside_jsonExport"
MODEL_FILE_PATH = MODEL_DIR_PATH / "json_export_model.sysml"

# # electronics model
# MODEL_DIR_PATH = EXAMPLE_DIR / "generic_electronics"
# MODEL_FILE_PATH = MODEL_DIR_PATH / "pcba_simulation.sysml"


def main() -> None:
    (model, diagnostics) = syside.try_load_model([MODEL_FILE_PATH])

    # Only errors cause an exception. SysIDE may also report warnings and
    # informational messages, but not for this example.
    assert not diagnostics.contains_errors(warnings_as_errors=True)

    # Export the model to JSON
    assert len(model.user_docs) == 1

    with model.user_docs[0].lock() as locked:
        raw_data = syside.json.dumps(
                locked.root_node, syside.SerializationOptions.minimal()
            )
        data = json.loads(raw_data)
        # print(data)
        # cleaned_data = data.replace('\n', '').replace('\"', '"')
        # decoded_data = codecs.decode(data, 'unicode_escape')
        with open(MODEL_DIR_PATH / "output.json", "w") as f:
            # json.dump(cleaned_data, f)
            json.dump(data, f)
            # for key, value in data.items():
            #     print(f"{key}: {value}", file=f)


if __name__ == "__main__":
    main()
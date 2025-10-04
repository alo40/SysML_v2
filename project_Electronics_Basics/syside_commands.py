# import syside_license
# syside_license.check()  # Validates your license
import syside

model, diagnostics = syside.load_model(["project_Electronics_Basics/electronics_basic.sysml"])
print('model loaded')
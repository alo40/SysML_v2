import random
import re
import typing
import pydot
import statemachine
from statemachine.contrib.diagram import DotGraphMachine
from IPython.display import Image
from syside_helpers import get_node, set_feature_value
import syside
import syside.helpers


class StateMachine:
    """A helper class for generating a ``python-statemachine`` state machine
    from a SysMLv2 state machine."""

    def __init__(
        self, model: syside.Model, state_machine_node: syside.StateDefinition
    ):
        """Note that only the states and transitions directly owned by the
        state machine are considered."""
        self.model = model
        self.state_machine_node = state_machine_node
        for succession in model.nodes(syside.SuccessionAsUsage):
            if succession.source == state_machine_node.entry_action:
                self.initial_states = succession.targets.collect()
                break
        else:
            raise ValueError("Could not find initial state.")

        self.states = []
        self.states_by_name = {}
        self.transitions: list[syside.TransitionUsage] = []
        self.transitions_by_name = {}
        self.transitions_from_source: dict[
            syside.StateUsage, list[syside.TransitionUsage]
        ] = {}
        self.transitions_to_target: dict[
            syside.StateUsage, list[syside.TransitionUsage]
        ] = {}
        for child in state_machine_node.children.elements:
            if child.try_cast(syside.StateUsage):
                self.states.append(child)
                self.states_by_name[child.name] = child
            elif transition := child.try_cast(syside.TransitionUsage):
                self.transitions.append(transition)
                self.transitions_by_name[transition.name] = transition
                assert isinstance(transition.source, syside.StateUsage)
                if transition.source not in self.transitions_from_source:
                    self.transitions_from_source[transition.source] = []
                    self.transitions_to_target[transition.source] = []
                self.transitions_from_source[transition.source].append(
                    transition
                )
                self.transitions_to_target[transition.source].append(transition)

    def create_python_state_machine(
        self, *args: typing.Any, **kwargs: typing.Any
    ) -> statemachine.StateMachine:
        """Create a state machine using ``python-statemachine`` package."""
        definition: dict[str, typing.Any] = {
            "_sysml_sm": self,
        }
        all_transitions = None
        for state in self.states:
            is_initial = any(
                initial_state == state for initial_state in self.initial_states
            )
            py_state = statemachine.State(initial=is_initial)
            assert state.name is not None
            definition[state.name] = py_state
        for transition in self.transitions:
            assert transition.source is not None
            assert transition.source.name is not None
            assert transition.target is not None
            assert transition.target.name is not None
            source_state = definition[transition.source.name]
            target_state = definition[transition.target.name]
            assert transition.trigger_action is not None
            assert transition.trigger_action.payload_argument is not None
            expression = transition.trigger_action.payload_argument

            def mk_condition(
                expression: syside.Expression,
            ) -> typing.Callable[[typing.Any, typing.Any], typing.Any]:
                def condition(
                    self: typing.Any, event_data: typing.Any
                ) -> typing.Any:
                    cond = self._sysml_sm._evaluate_expression(
                        expression, event_data
                    )
                    return cond

                return condition

            assert transition.name is not None
            definition[transition.name] = mk_condition(expression)
            if all_transitions is None:
                all_transitions = source_state.to(
                    target_state, cond=transition.name
                )
            else:
                all_transitions = all_transitions | source_state.to(
                    target_state, cond=transition.name
                )
        definition["transition"] = all_transitions

        assert self.state_machine_node.name is not None
        state_machine_class: type[statemachine.StateMachine] = type(
            self.state_machine_node.name,
            (statemachine.StateMachine,),
            definition,
        )
        return state_machine_class(*args, **kwargs)

    def _evaluate_expression(
        self, expression: syside.Expression, event_data: typing.Any
    ) -> typing.Any:
        for key, value in event_data.args[0].items():
            try:
                _ = get_node(self.model, key)
            except KeyError:
                pass
            else:
                set_feature_value(self.model, key, value)
        compiler = syside.Compiler()
        (_membership, feature) = expression.children[0]
        assert isinstance(feature, syside.Feature)
        assert feature.feature_value_expression is not None
        value, report = compiler.evaluate(feature.feature_value_expression)
        assert not report.fatal
        assert not report.diagnostics
        return value


def _render_state_machine_to_dot(
    state_machine: statemachine.StateMachine,
) -> pydot.Dot:
    graph = DotGraphMachine(state_machine)
    dot = graph()
    result_string = re.sub(r"(\d+)pt", r"\1", dot.to_string())
    result = pydot.graph_from_dot_data(result_string)
    if result is None:
        raise RuntimeError(f"Failed to parse dot:\n{dot}")

    return result[0]


def render_state_machine(state_machine: statemachine.StateMachine) -> Image:
    """Render `state_machine` in Jupyter."""
    graph = _render_state_machine_to_dot(state_machine)
    return Image(graph.create(format="png"))


def render_graph_to_file(
    state_machine: statemachine.StateMachine, png_path: str
) -> None:
    """Render `state_machine` in PNG file `png_path`."""
    graph = _render_state_machine_to_dot(state_machine)
    graph.write(format="png", path=png_path)


def sensor_readings_generator(
    seed: int,
    count: int,
    step_size: int = 5,
    temp_lower: int = 1,
    temp_higher: int = 30,
) -> typing.Generator[dict[typing.Any, typing.Any], None, None]:
    """Infinitely generates random temperature readings."""
    random.seed(seed)
    temp = random.randint(temp_lower, temp_higher)
    for _ in range(count):
        temp = random.randint(
            max(temp_lower, temp - step_size),
            min(temp_higher, temp + step_size),
        )
        yield {
            ("Demo", "Fridge_Actions", "readSensors", "temp"): temp,
        }

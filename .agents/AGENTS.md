# Thimar Project Rules

The following rules represent architectural and coding standards specific to the Thimar project. You must STRICTLY adhere to them at all times.

## 1. Cubit & Controller Initialization
- **Cubit Initialization**: Always instantiate the Cubit inline in the View file using Service Locator (`sl`), rather than defining it as `late final` and initializing it inside `initState()`.
  - ✅ **Correct:** `final _cubit = sl<MyCubit>();` or `final _cubit = sl<MyCubit>()..getData();`
  - ❌ **Incorrect:** `late final MyCubit _cubit; ... void initState() { _cubit = sl<MyCubit>(); }`
- **Controllers placement**: `TextEditingController` and `FocusNode` instances must ALWAYS be defined and disposed of inside the Cubit, never in the View.

## 2. Global Guidelines Enforcement
- Ensure that any UI component that requires `dispose()` for memory management (like controllers) is properly handled in the `close()` method of the `Cubit`.

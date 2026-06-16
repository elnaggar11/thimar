part of 'policy_cubit.dart';

class PolicyState {
  final RequestState state;
  final String policyHtml;

  PolicyState({
    this.state = RequestState.initial,
    this.policyHtml = '',
  });

  PolicyState copyWith({
    RequestState? state,
    String? policyHtml,
  }) {
    return PolicyState(
      state: state ?? this.state,
      policyHtml: policyHtml ?? this.policyHtml,
    );
  }
}

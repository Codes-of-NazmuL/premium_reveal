## 1.0.0

- Initial release of `premium_reveal`.
- Seamless staggered entry animations:
  - `PremiumReveal` widget and `.reveal(...)` extension on `Widget`.
  - `PremiumStaggeredColumn` for auto-sequenced vertical layouts.
  - `PremiumStaggeredRow` for auto-sequenced horizontal layouts.
  - `PremiumPageTransitionsBuilder` for route transitions matching the reveal motion curve.
- Automatic route synchronization with `ModalRoute`.
- Zero external package dependencies.
- Full accessibility support via `MediaQuery.disableAnimationsOf`.

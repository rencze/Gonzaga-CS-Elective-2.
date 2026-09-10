# Tech Shop - Prelim Exam

A Flutter shop browser for CS Elective 2. Work is on the `PrelimExam` branch.

## Shopping flow

Home product grid -> Product detail -> Add to Cart -> Cart -> Checkout confirmation.

- Home shows the complete catalog, search, favorites, and a light/dark toggle.
  The header uses `lib/images/logo.png`, with an editable `logo.svg` source.
- The catalog combines category filters, multiword search, favorites, live result
  counts, and ascending/descending price sorting. Filters can be cleared together.
- Product details include local images, prices, descriptions, highlights, sample
  reviews, and a quantity selector with a live selected total.
- Add-to-cart notices dismiss after three seconds. Repeated additions replace
  the current notice; the View cart action remains available during that time.
- The cart shows short descriptions, sample rating summaries, quantity controls,
  item subtotals, and a running total. Each product is limited to 1-10 units;
  removal is a separate action. The limit includes units already in the cart.
- Removed cart items can be restored with Undo for three seconds. Tapping a cart
  item opens its details. An empty cart links directly to browsing and hides the
  order summary until an item is added.
- Checkout snapshots the order, clears the cart once, and shows an itemized
  confirmation. Empty-cart navigation to `/checkout` redirects home.

This is a frontend demo with no payment or backend. Reviews are explicitly
labeled fictional samples. Cart and favorites reset when the app restarts.

The UI refinements follow [Baymard's product-list information guidance](https://baymard.com/blog/product-listing-information),
[sorting research](https://baymard.com/blog/essential-sort-types), and
[NN/g's empty-state guidance](https://www.nngroup.com/articles/empty-state-interface-design/):
keep comparison information visible, offer relevant browsing controls, and give
empty states a direct next action. The existing violet theme and local images remain.

## Exam requirements and implementation

| Requirement | Implementation |
| --- | --- |
| Navigation 2.0 | `go_router` handles `/`, `/products`, `/product/:id`, `/cart`, and `/checkout`. |
| Responsive grid | Home and catalog share `GridView.builder`, `LayoutBuilder`, and `MediaQuery`: 2 columns below 600 logical pixels, 3 from 600-899, and 4 from 900. The grid reflows when the window resizes; card heights account for scaled text. |
| Responsive detail/cart | Scrollable content, wrapping details, desktop columns, and a compact bottom summary on phones. |
| Consistent theming | One `AppTheme._build` definition produces both brightness modes at `MaterialApp.router`. All color constants live under `lib/theme`; `ShopColors` extends ThemeData for image and review colors. |
| Required widgets | Every screen has a `Scaffold` and `AppBar`; product and review displays use `Card`, `Image`, and `Text`. |
| Static presentation | `ProductCard`, `ProductImage`, `ProductReviews`, and cart tiles are StatelessWidgets: they render data passed to them. |
| Interactive state | `ShopApp` owns theme mode. `ProductDetailScreen` owns selected quantity and add feedback. `QuantityStepper` uses `setState` for immediate interaction and synchronizes parent updates in `didUpdateWidget`. |
| Shared cart state | `CartController` is authoritative for stored quantities and totals, exposed through `CartInherited`. Stepper callbacks update this controller; UI does not invent its own cart formulas. |
| Confirmation state | `CheckoutConfirmationScreen` snapshots the receipt in `initState` and clears the cart once after the first frame. |

## Run and verify

```sh
flutter pub get
flutter run
flutter analyze
flutter test
flutter build web
```

Local validation covered cart limits and bulk additions, notice timing, live totals, navigation guards,
receipt retention, theme changes, search/favorites, and the full shopping flow
at phone/tablet widths with enlarged text.

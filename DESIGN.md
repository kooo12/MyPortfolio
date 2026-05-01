---
name: Digital Craft
colors:
  surface: '#131313'
  surface-dim: '#131313'
  surface-bright: '#393939'
  surface-container-lowest: '#0e0e0e'
  surface-container-low: '#1c1b1b'
  surface-container: '#201f1f'
  surface-container-high: '#2a2a2a'
  surface-container-highest: '#353534'
  on-surface: '#e5e2e1'
  on-surface-variant: '#c1c6d7'
  inverse-surface: '#e5e2e1'
  inverse-on-surface: '#313030'
  outline: '#8b90a0'
  outline-variant: '#414755'
  surface-tint: '#adc6ff'
  primary: '#adc6ff'
  on-primary: '#002e69'
  primary-container: '#4b8eff'
  on-primary-container: '#00285c'
  inverse-primary: '#005bc1'
  secondary: '#b9c8de'
  on-secondary: '#233143'
  secondary-container: '#39485a'
  on-secondary-container: '#a7b6cc'
  tertiary: '#c6c6c7'
  on-tertiary: '#2f3131'
  tertiary-container: '#909191'
  on-tertiary-container: '#282a2a'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#d8e2ff'
  primary-fixed-dim: '#adc6ff'
  on-primary-fixed: '#001a41'
  on-primary-fixed-variant: '#004493'
  secondary-fixed: '#d4e4fa'
  secondary-fixed-dim: '#b9c8de'
  on-secondary-fixed: '#0d1c2d'
  on-secondary-fixed-variant: '#39485a'
  tertiary-fixed: '#e2e2e2'
  tertiary-fixed-dim: '#c6c6c7'
  on-tertiary-fixed: '#1a1c1c'
  on-tertiary-fixed-variant: '#454747'
  background: '#131313'
  on-background: '#e5e2e1'
  surface-variant: '#353534'
typography:
  display:
    fontFamily: Space Grotesk
    fontSize: 72px
    fontWeight: '700'
    lineHeight: '1.1'
    letterSpacing: -0.04em
  h1:
    fontFamily: Space Grotesk
    fontSize: 48px
    fontWeight: '600'
    lineHeight: '1.2'
    letterSpacing: -0.02em
  h2:
    fontFamily: Space Grotesk
    fontSize: 32px
    fontWeight: '600'
    lineHeight: '1.3'
  body-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '400'
    lineHeight: '1.6'
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: '1.6'
  label-caps:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: '1.2'
    letterSpacing: 0.1em
  code:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '500'
    lineHeight: '1.5'
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 8px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 48px
  xxl: 96px
  container-max: 1200px
  gutter: 24px
---

## Brand & Style
This design system centers on a "Technical Premium" aesthetic, engineered for a mid-level Flutter developer who balances architectural precision with fluid user experiences. The brand personality is sophisticated and forward-looking, evoking the feeling of a high-end IDE or a stealth-mode startup dashboard.

The visual style is a hybrid of **Minimalism** and **Subtle Glassmorphism**. It prioritizes extreme legibility and generous whitespace to showcase technical depth without overwhelming the viewer. High-contrast typography acts as the primary visual driver, while glassmorphic surfaces provide the "2026 edge"—signaling a mastery of modern rendering engines and layered UI architectures.

## Colors
The palette is anchored by **Deep Charcoal (#121212)** to provide an infinite depth for the dark mode experience. **Electric Blue (#007AFF)** serves as the "Action Core," utilized sparingly for primary interactions, syntax highlighting, and progress indicators to maintain high chromatic tension.

**Slate Grays (#94A3B8)** are used for secondary information and structural borders, ensuring the hierarchy remains clear without the harshness of pure white. Text uses a tiered grayscale approach: Pure White for headings, Slate Gray for body, and a 50% opacity slate for metadata.

## Typography
The typographic system utilizes **Space Grotesk** for headlines to inject a technical, geometric edge that reflects the developer's proximity to the "metal." Its distinctive glyphs provide the "2026" futuristic character. 

**Inter** is employed for all functional and body text to ensure maximum readability and a systematic, utilitarian feel. The hierarchy relies on extreme scale contrast—large, tight-tracked displays paired with spacious, airy body copy. Vertical rhythm is strictly enforced via a 4px baseline grid.

## Layout & Spacing
The layout follows a **Fluid Grid** model with a 12-column structure for desktop and a single-column stack for mobile. Spacing is governed by a strict 8px increment system, favoring larger values (48px+) to create the "premium" sense of breathing room.

Margins are generous (minimum 24px on mobile, 96px+ on desktop) to center the focus on the content. Content blocks should leverage "optical padding"—where internal padding is slightly larger than the gutter to create a sense of containment within the dark void.

## Elevation & Depth
Depth is communicated through **Glassmorphism** and **Tonal Layering** rather than traditional shadows. 

1.  **Base Layer:** Deep Charcoal (#121212) - The canvas.
2.  **Raised Layer:** Surface Gray (#1E1E1E) with a 1px subtle border (#FFFFFF at 5% opacity).
3.  **Overlay Layer:** Backdrop blur (20px) with a semi-transparent Slate Gray fill (10% opacity).

This design system avoids heavy shadows, opting instead for "Inner Glows" and hairline strokes to define edges. This mimics the appearance of a high-end backlit display or hardware interface.

## Shapes
The shape language is consistently **Rounded (Level 2)**. Standard elements like cards and input fields use an 8px (0.5rem) radius. Larger container elements and portfolio project cards should scale up to 16px (1rem) or 24px (1.5rem) to feel more approachable and modern.

Interactive elements like tags and "view more" buttons may use pill-shapes to differentiate them from structural layout components. All strokes should be kept at a precise 1px or 1.5px width to maintain a "Retina-ready" technical sharpness.

## Components
### Buttons
Primary buttons use the **Electric Blue** fill with white text, featuring a subtle outer glow on hover. Secondary buttons use a ghost style: a 1px Slate Gray border that transitions to a solid gray fill on interaction.

### Cards
Portfolio project cards must utilize **Glassmorphism**. A background blur of 20px-30px combined with a 1px white border at 10% opacity creates the premium "floating glass" effect. Images within cards should have a subtle desaturation filter (80%) that returns to full color on hover.

### Chips & Tags
Used for tech stacks (e.g., "Flutter", "Dart", "Firebase"). These are small, low-contrast elements with a Slate Gray background at 15% opacity and Slate Gray text. They should have no border to keep the UI clean.

### Input Fields
Inputs are dark-on-dark. Background is #1E1E1E with a bottom-only border in Electric Blue that animates from 0% to 100% width upon focus.

### Code Snippets
As a developer portfolio, code blocks are first-class components. Use a custom syntax highlighting theme based on the Electric Blue and Slate Gray palette, wrapped in a container with a distinct 2px border-radius and a "copy" icon in the top-right.
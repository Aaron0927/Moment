---
name: Life Archive
colors:
  surface: '#fcf9f8'
  surface-dim: '#dcd9d9'
  surface-bright: '#fcf9f8'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f6f3f2'
  surface-container: '#f0eded'
  surface-container-high: '#eae7e7'
  surface-container-highest: '#e4e2e1'
  on-surface: '#1b1c1c'
  on-surface-variant: '#53433d'
  inverse-surface: '#303030'
  inverse-on-surface: '#f3f0f0'
  outline: '#86736c'
  outline-variant: '#d8c2b9'
  surface-tint: '#8d4d2f'
  primary: '#8d4d2f'
  on-primary: '#ffffff'
  primary-container: '#f4a27e'
  on-primary-container: '#71371b'
  inverse-primary: '#ffb596'
  secondary: '#566342'
  on-secondary: '#ffffff'
  secondary-container: '#d7e5bb'
  on-secondary-container: '#5a6745'
  tertiary: '#615e57'
  on-tertiary: '#ffffff'
  tertiary-container: '#bab5ad'
  on-tertiary-container: '#494740'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#ffdbcd'
  primary-fixed-dim: '#ffb596'
  on-primary-fixed: '#360f00'
  on-primary-fixed-variant: '#70361b'
  secondary-fixed: '#dae8be'
  secondary-fixed-dim: '#becca3'
  on-secondary-fixed: '#141f05'
  on-secondary-fixed-variant: '#3f4b2c'
  tertiary-fixed: '#e7e2d9'
  tertiary-fixed-dim: '#cbc6bd'
  on-tertiary-fixed: '#1d1b16'
  on-tertiary-fixed-variant: '#494640'
  background: '#fcf9f8'
  on-background: '#1b1c1c'
  surface-variant: '#e4e2e1'
typography:
  display:
    fontFamily: Plus Jakarta Sans
    fontSize: 48px
    fontWeight: '700'
    lineHeight: '1.2'
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 32px
    fontWeight: '600'
    lineHeight: '1.3'
  headline-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 24px
    fontWeight: '600'
    lineHeight: '1.4'
  body-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 18px
    fontWeight: '400'
    lineHeight: '1.6'
  body-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 16px
    fontWeight: '400'
    lineHeight: '1.6'
  label-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 13px
    fontWeight: '600'
    lineHeight: '1.4'
    letterSpacing: 0.05em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 8px
  container-margin: 24px
  gutter: 16px
  stack-sm: 12px
  stack-md: 24px
  stack-lg: 48px
---

## Brand & Style

The design system is anchored in the concept of "Digital Heirloom"—a space that feels as precious as a physical journal but as fluid as a modern application. It targets individuals who value mindfulness and the long-term perspective of their life journey. The emotional response is one of calm reflection and gentle optimism.

The visual style is a blend of **Minimalism** and **Tactile Modernism**. It leverages heavy whitespace to reduce cognitive load and focuses on high-quality typography to convey a sense of story. The interface avoids cold, clinical layouts in favor of soft, organic compositions that feel human-made.

## Colors

The palette is inspired by natural pigments and vintage stationery. 
- **Soft Apricot (Primary):** Used for primary actions and highlighting key life milestones. It radiates warmth and energy.
- **Sage Green (Secondary):** Used for growth-related metrics, routine tracking, and calm states.
- **Cream (Background):** The canvas of the application. It provides a softer contrast than pure white, reducing eye strain and adding a nostalgic, paper-like quality.
- **Deep Charcoal (Text):** Ensures high legibility while remaining softer and more organic than true black.
- **Success/Warning/Error:** Derived from the primary palette using desaturated tones to maintain the calm aesthetic.

## Typography

The design system utilizes **Plus Jakarta Sans** across all levels. This choice provides a contemporary, geometric foundation with softened terminals that feel approachable. 

- **Headlines:** Use tighter letter spacing and semi-bold weights to create a strong visual anchor for dates and titles.
- **Body Text:** Set with generous line heights (1.6) to ensure a comfortable reading experience for long-form journaling entries.
- **Labels:** Uppercase styling is used sparingly for metadata to provide a clear distinction from narrative content.

## Layout & Spacing

This design system employs a **Fluid Grid** with a 12-column structure for desktop and a single-column flow for mobile. The spacing rhythm is based on an 8px square module.

Generous padding is a core principle. Content should never feel "cramped" against the edges of its container. Large vertical gaps (stack-lg) are used to separate chronological blocks (e.g., years or months), while tighter spacing (stack-sm) groups related metadata with its primary content.

## Elevation & Depth

Visual hierarchy is achieved through **Ambient Shadows** and **Tonal Layering**. 

1.  **Base Layer:** The Cream background (#FFF9F0) serves as the foundation.
2.  **Surface Layer:** Cards and interactive elements sit slightly above the base.
3.  **Shadows:** Use a "feathered" technique—low opacity (10-15%) with a large blur radius (20px+) and a slight Y-offset. Shadows are tinted with a hint of the primary color to keep them warm rather than grey.
4.  **Transitions:** Subtle 200ms ease-in-out transforms are used on hover to lift cards further, simulating the physical act of picking up a photograph or a card.

## Shapes

The shape language is consistently **Rounded**. 

- **Primary Containers:** 1rem (16px) corner radius to soften the edges of the "life tiles."
- **Small Elements:** Buttons and tags use a 0.5rem (8px) radius to maintain a cohesive look without becoming fully circular.
- **Image Frames:** Always use the container's roundedness to ensure photos of memories feel integrated into the UI.

## Components

- **Buttons:** Large, tactile tap targets with Soft Apricot backgrounds. Text is Deep Charcoal. High-emphasis buttons use a subtle inner glow to appear slightly convex.
- **Cards (Life Tiles):** The primary container for memories. They feature a 1px soft border (#E0D7C6) and an ambient shadow. 
- **Chips:** Used for "Life Categories" (e.g., Career, Travel). These use desaturated versions of the Sage Green and Apricot to categorize without distracting.
- **Inputs:** Minimalist bottom-border styles or fully enclosed fields with the Cream background and a slightly darker stroke.
- **Iconography:** Outlined, 2px stroke width, with rounded caps and joins. Icons should feel "sketched" yet precise.
- **Timeline Rail:** A vertical line in desaturated Sage Green that connects life events, utilizing soft circles as nodes.
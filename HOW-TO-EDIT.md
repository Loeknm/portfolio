# How to edit your portfolio

All content lives in the **`content/`** folder. You never need to touch the HTML, CSS or JavaScript to change what's on the site.

| File | What's in it |
| --- | --- |
| `content/text.json` | Every text on the site: name, age, study, intro, about, contact, button labels |
| `content/projects.json` | Your projects (text) — one block per project |
| `content/images.json` | Every image slot, each with a `_where` note saying where it appears and what size to use |
| `images/` | Put your own image files here (optional — you can also use https:// links) |

## Previewing

Double-click **`start-preview.bat`**. It opens the site at `http://localhost:5500` in your browser.
Save a JSON file → refresh the browser → you see the change. Close the black window to stop.

> Opening `index.html` directly (double-click) shows an error: browsers don't let a local file read JSON files. On a real web host (GitHub Pages, Netlify, your school's server) everything just works.

## JSON rules (the only 4 things that can go wrong)

1. Text always goes between **double quotes**: `"title": "My project"`
2. Every item is followed by a **comma**, except the **last** one in a list or block.
3. Lists use square brackets: `["Figma", "Illustrator"]`
4. Don't delete the names on the left (`"title":`), only change the values on the right.

If you make a typo, the site shows a box telling you **which file and which line** to fix.
Keys starting with `_` (like `_note`, `_where`) are just notes for you; the site ignores them.

**Tip:** reuse values with curly braces, so you only type things once. For example
`"value": "{study.programmeShort} — {study.school}"` shows "CMD — Your School".

## Adding a project

1. In `content/projects.json`, copy a full block from `{` to `}`, paste it after the last project and put a comma between the two blocks.
2. Give it a **new, unique `id`** (lowercase, no spaces, e.g. `"poster-campaign"`).
3. In `content/images.json`, under `"projects"`, add a block with the **same id**:
   ```json
   "poster-campaign": {
     "cover":   { "url": "images/poster-cover.jpg", "alt": "Poster campaign cover" },
     "gallery": [
       { "url": "images/poster-1.jpg", "alt": "" },
       { "url": "images/poster-2.jpg", "alt": "", "fit": "contain" }
     ]
   }
   ```
   No images yet? Skip this step — the project shows gradient placeholders.

The slider, grid, counters, progress bar and previous/next links all update automatically, however many projects you add. Set `"hidden": true` to keep a draft off the site. The order in `projects.json` is the order on the site.

## Checklist — everything you need to fill in

### `content/text.json`
- [ ] `person.firstName`, `person.lastName`, `person.initials`
- [ ] `person.birthDate` (keeps your age up to date) **or** `person.age`
- [ ] `person.city`, `person.country`, `person.timezone`
- [ ] `person.email`
- [ ] `study.programme`, `study.programmeShort`, `study.school`, `study.year`, `study.period`
- [ ] `meta.brandSubtitle` (small text under your name, top-left) and `meta.language`
- [ ] `home.introBefore`, `home.rotatingWords`, `home.introAfter`
- [ ] `home.facts` (check they say what you want)
- [ ] `about.titleLine1`, `about.titleLine2`, `about.intro`
- [ ] `about.columns` → Skills, Tools, Beyond design items
- [ ] `contact.badge` (or `"showBadge": false`)
- [ ] `contact.socials` → your real profile links (empty `url` = button hidden)
- [ ] Optional: page title/description (`meta`), button labels, and everything under `interface` (menu, hints — e.g. to translate the site to Dutch)

### `content/images.json`
- [ ] `site.portrait` — About page photo (3:4)
- [ ] `site.favicon` — browser tab icon (square)
- [ ] Optional: `site.logo` — replaces your initials in the top-left circle
- [ ] Per project: `cover` + `gallery` images

### `content/projects.json` — per project
- [ ] `id`, `title`, `type`, `course`, `year`, `tools`
- [ ] `summary` (one sentence for the slider)
- [ ] `overview`, `process`, `result` (empty tabs are hidden automatically)
- [ ] `link` (optional)

## Changing the look

- Colors, fonts, spacing: the top of `css/style.css` (`:root` for dark mode, `[data-theme="light"]` for light mode).
- Particle shapes per page: `preset()` at the top of `js/particles.js`.

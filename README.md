# Insights JSON Builder

A visual browser for published insights articles. Loads all articles from the
2024, 2025, and 2026 XML feeds into a chronological timeline, lets you tick the
articles you want, and exports their raw feed node data as JSON.

**Live demo:** <https://justinlbannister.github.io/Insights-JSON-Builder/>

## What it does

- Fetches three published XML feeds and parses them into ~476 articles
- Groups articles by month with a sticky month rail for quick navigation
- Filters by year, format (audio / video / text), and title/description search
- Ticking an article reveals every field from its feed node — date, link,
  thumbnail, title, description, category, region, author, tags, readtime,
  watchtime, type, story-type, video — in the right-side inspector
- **Export JSON** dumps the raw node data for every selected article
- **Copy JSON** copies the payload straight to the clipboard

Runs entirely in the browser. No backend, no build step, no dependencies.

## How to use

1. Open the demo URL
2. Wait a few seconds for the feeds to load
3. Scroll or click a month in the left rail to jump to a date range
4. Use search / year / format filters to narrow the list
5. Tick any article to add it to the "Selected" panel on the right
6. Every field from that article's feed node appears in the panel
7. When you have the set you want, click **Export JSON** or **Copy JSON**

## Under the hood

The three insights XML endpoints don't send permissive CORS headers, so a
public CORS proxy (`api.allorigins.win/raw`) relays the requests. That means
the tool works from any origin — GitHub Pages, Netlify, a local file, or a
pinned tab.

If the proxy is ever unavailable, the tool won't load feeds. There's no
embedded fallback data in this build — it's a live-only viewer.

## File layout

Single `index.html` file. Everything is inline — no external CSS, no bundler,
no dependencies except the browser's built-in DOM and Fetch APIs.
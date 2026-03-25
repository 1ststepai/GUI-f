# agent_scout.ps1 - AI Agent Tool Scout
# Opens browsers to news sites and scrapes for trending AI Agent tools

$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Open browsers
Start-Process "https://news.ycombinator.com"
Start-Process "https://reddit.com/r/ChatGPT"

# Create Python script for scraping
$pythonScript = @"
import requests
from bs4 import BeautifulSoup
import re
import os

def fetch_page(url, selectors):
    try:
        headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'}
        resp = requests.get(url, headers=headers, timeout=10)
        soup = BeautifulSoup(resp.text, 'html.parser')
        results = []
        for sel in selectors:
            for item in soup.select(sel):
                text = item.get_text(strip=True)
                if text and len(text) > 10:
                    results.append(text)
        return results
    except Exception as e:
        return [f'Error: {str(e)}']

# Hacker News - top stories
hn_items = []
try:
    headers = {'User-Agent': 'Mozilla/5.0'}
    resp = requests.get('https://news.ycombinator.com', headers=headers, timeout=10)
    soup = BeautifulSoup(resp.text, 'html.parser')
    for i, tr in enumerate(soup.select('.athing')):
        if i >= 30:
            break
        title_elem = tr.select_one('.titleline a')
        if title_elem:
            title = title_elem.get_text(strip=True)
            link = title_elem.get('href', '')
            hn_items.append((title, link))
except Exception as e:
    pass

# Reddit r/ChatGPT - hot posts
reddit_items = []
try:
    headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'}
    resp = requests.get('https://www.reddit.com/r/ChatGPT/hot.json?limit=50', headers=headers, timeout=10)
    data = resp.json()
    for post in data['data']['children']:
        title = post['data']['title']
        reddit_items.append(title)
except Exception as e:
    pass

# Find AI Agent related items
agent_keywords = ['agent', 'ai agent', 'autonomous', 'agentic', 'agent framework', 'agent platform', 'ai tool', 'automation']

def is_agent_related(text):
    text_lower = text.lower()
    for kw in agent_keywords:
        if kw in text_lower:
            return True
    return False

hn_agents = [(t, l) for t, l in hn_items if is_agent_related(t)][:5]
reddit_agents = [t for t in reddit_items if is_agent_related(t)][:5]

# Build output
output = []
output.append('# AI Agent Tools - Trending Now\n')
output.append(f'*Scraped from Hacker News and r/ChatGPT on*\n\n')

output.append('## Top Trending AI Agent Tools\n\n')

all_tools = []
seen = set()

for title, link in hn_agents:
    key = title.lower()[:30]
    if key not in seen:
        seen.add(key)
        all_tools.append(('HN', title, link))

for title in reddit_agents:
    key = title.lower()[:30]
    if key not in seen:
        seen.add(key)
        all_tools.append(('Reddit', title, ''))

if all_tools:
    output.append('| # | Source | Tool/Project | Why It\'s Trending |\n')
    output.append('|---|--------|--------------|-------------------|\n')
    for i, (src, title, link) in enumerate(all_tools[:3], 1):
        link_str = f'[{title}]({link})' if link else title
        output.append(f'| {i} | {src} | {link_str} | Popular in AI community |\n')
else:
    output.append('No specific AI Agent tools found in top results.\n')

output.append('\n## Summary\n')
output.append(f'- Analyzed top 30 items from Hacker News\n')
output.append(f'- Analyzed hot posts from r/ChatGPT\n')
output.append(f'- Found {len(all_tools)} AI Agent related items\n')

with open('trending_now.md', 'w', encoding='utf-8') as f:
    f.write(''.join(output))

print('Scraping complete. Results saved to trending_now.md')
"@

$pythonScript | Out-File -FilePath "$scriptDir\scraper.py" -Encoding UTF8

# Run the scraper
python "$scriptDir\scraper.py"

# Cleanup
Remove-Item "$scriptDir\scraper.py" -Force -ErrorAction SilentlyContinue

Write-Host "Done! Check trending_now.md for results."
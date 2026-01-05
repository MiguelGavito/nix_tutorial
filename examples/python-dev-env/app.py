#!/usr/bin/env python3
"""
GitHub Repository Analyzer
A practical example showing how Nix manages Python dependencies
"""

import requests
import sys
from rich.console import Console
from rich.table import Table
from rich.panel import Panel
from datetime import datetime

console = Console()

def get_repo_stats(owner, repo):
    """Fetch repository statistics from GitHub API"""
    url = f"https://api.github.com/repos/{owner}/{repo}"
    
    try:
        response = requests.get(url, timeout=10)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        console.print(f"[red]Error fetching repository: {e}[/red]")
        return None

def display_stats(data):
    """Display repository statistics in a pretty table"""
    
    # Create main info panel
    license = data.get('license') or {}
    license_name = license.get('name', 'None') if isinstance(license, dict) else 'None'

    info = f"""
[bold cyan]Repository:[/bold cyan] {data['full_name']}
[bold cyan]Description:[/bold cyan] {data.get('description', 'No description')}
[bold cyan]Created:[/bold cyan] {data['created_at'][:10]}
[bold cyan]Language:[/bold cyan] {data.get('language', 'N/A')}
[bold cyan]License:[/bold cyan] {license_name}
    """
    
    console.print(Panel(info, title="📊 Repository Information", border_style="cyan"))
    
    # Create statistics table
    table = Table(title="Statistics", show_header=True, header_style="bold magenta")
    table.add_column("Metric", style="cyan", width=20)
    table.add_column("Count", justify="right", style="green")
    
    table.add_row("⭐ Stars", str(data['stargazers_count']))
    table.add_row("👀 Watchers", str(data['watchers_count']))
    table.add_row("🍴 Forks", str(data['forks_count']))
    table.add_row("🐛 Open Issues", str(data['open_issues_count']))
    table.add_row("📦 Size (KB)", str(data['size']))
    
    console.print(table)
    
    # Additional info
    console.print(f"\n[bold green]✓[/bold green] Repository is {'public' if not data['private'] else 'private'}")
    console.print(f"[bold green]✓[/bold green] Default branch: {data['default_branch']}")
    
    if data.get('homepage'):
        console.print(f"[bold cyan]🔗 Homepage:[/bold cyan] {data['homepage']}")
    
    console.print(f"\n[dim]Last updated: {data['updated_at'][:10]}[/dim]")

def main():
    if len(sys.argv) < 2:
        console.print("[yellow]Usage:[/yellow] python3 app.py <owner>/<repo>")
        console.print("[yellow]Example:[/yellow] python3 app.py octocat/Hello-World")
        console.print("[yellow]Example:[/yellow] python3 app.py torvalds/linux")
        sys.exit(1)
    
    repo_path = sys.argv[1]
    
    if '/' not in repo_path:
        console.print("[red]Error:[/red] Repository must be in format: owner/repo")
        sys.exit(1)
    
    owner, repo = repo_path.split('/', 1)
    
    console.print(f"\n[bold]Fetching stats for {owner}/{repo}...[/bold]\n")
    
    data = get_repo_stats(owner, repo)
    
    if data:
        display_stats(data)
        console.print("\n[green]✓ Analysis complete![/green]\n")
    else:
        console.print("[red]Failed to fetch repository data[/red]")
        sys.exit(1)

if __name__ == '__main__':
    main()

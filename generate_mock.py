import json

mock_data = [
    {
        "name": "Red Light Therapy Mask",
        "retail": 179.00,
        "landed": 22.50,
        "profit": 145.76,
        "score": 9,
        "url": "https://1688.com/example_led_mask",
        "hook_rate": "42%"
    },
    {
        "name": "4K Smart Mini Projector",
        "retail": 129.99,
        "landed": 45.00,
        "profit": 77.19,
        "score": 8,
        "url": "https://1688.com/example_projector",
        "hook_rate": "38%"
    },
    {
        "name": "24pc Moroccan Tile Stickers",
        "retail": 24.99,
        "landed": 4.20,
        "profit": 19.29,
        "score": 10,
        "url": "https://1688.com/example_stickers",
        "hook_rate": "31%"
    }
]

with open('scout_output.json', 'w') as f:
    json.dump(mock_data, f, indent=4)

print("✅ scout_output.json has been populated with 2026 winners.")
#!/usr/bin/env python3
"""Simple system stats API using Flask + psutil"""

from flask import Flask, jsonify
from flask_cors import CORS
import psutil
import datetime
import platform

app = Flask(__name__)
CORS(app)


def get_system_stats():
    cpu_percent = psutil.cpu_percent(interval=0.5)
    virtual_mem = psutil.virtual_memory()
    disk = psutil.disk_usage('/')
    boot_time = datetime.datetime.fromtimestamp(psutil.boot_time())

    return {
        "cpu_percent": cpu_percent,
        "memory": {
            "total_mb": round(virtual_mem.total / (1024 ** 2), 1),
            "used_mb": round(virtual_mem.used / (1024 ** 2), 1),
            "percent": virtual_mem.percent,
        },
        "disk": {
            "total_gb": round(disk.total / (1024 ** 3), 1),
            "used_gb": round(disk.used / (1024 ** 3), 1),
            "percent": disk.percent,
        },
        "boot_time": boot_time.isoformat(),
        "hostname": platform.node(),
        "platform": platform.platform(),
        "timestamp": datetime.datetime.utcnow().isoformat() + "Z",
    }


@app.route("/api/system")
def system():
    return jsonify(get_system_stats())


@app.route("/api/ping")
def ping():
    return jsonify({"status": "ok", "timestamp": datetime.datetime.utcnow().isoformat() + "Z"})


if __name__ == "__main__":
    print("🐍 Backend running on http://localhost:5000")
    print("Endpoints:")
    print("  /api/system   -> system metrics")
    print("  /api/ping     -> health check")
    print("Press Ctrl+C to stop")
    app.run(host="0.0.0.0", port=5000, debug=True, use_reloader=False)

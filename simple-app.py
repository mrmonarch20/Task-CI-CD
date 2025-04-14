from flask import Flask, jsonify, request
from datetime import datetime
import pytz

app = Flask(__name__)

@app.route("/", methods=["GET"])
def get_time_and_ip():
    ist = pytz.timezone('Asia/Kolkata')
    current_time = datetime.now(ist).isoformat()
    visitor_ip = request.remote_addr
    return jsonify({
        "timestamp": current_time,
        "ip": visitor_ip
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

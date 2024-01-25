import re
import json
import ipaddress
import subprocess
from urllib.request import urlopen
from concurrent.futures import ThreadPoolExecutor


def fetch_github_meta():
    url = "https://api.github.com/meta"
    try:
        with urlopen(url, timeout=10) as response:
            data = response.read().decode("utf-8")
            json_data = json.loads(data)
            ip_list = json_data.get("web", [])
            return ip_list
    except Exception as e:
        print(f"Fetch API error: {e}")
        return None


def parse_public_ipv4(cidr_list):
    results = []
    for cidr in cidr_list:
        try:
            network = ipaddress.IPv4Network(cidr, strict=False)
            if network.num_addresses != 1:
                continue
            ip_list = [format(ip) for ip in network if ip.is_global]
            results.append(ip_list[0])
        except ValueError:
            continue
    return results


def test_ip_latency(ip, test_count=5, timeout=10):
    latency = 999
    try:
        ping = subprocess.run(
            ["ping", "-c", str(test_count), "-W", str(timeout), ip],
            capture_output=True,
            text=True,
            timeout=timeout,
        )
        match = re.search(r"stddev = (.+?)/", ping.stdout)
        if match:
            latency = float(match.group(1))
    except subprocess.TimeoutExpired:
        pass

    return (ip, latency)


if __name__ == "__main__":
    cidr_list = fetch_github_meta()
    ip_list = parse_public_ipv4(cidr_list)

    with ThreadPoolExecutor() as executor:
        latencies = list(executor.map(test_ip_latency, ip_list))

    result = sorted(latencies, key=lambda x: x[1])
    for ip, latency in result:
        if latency == 999:
            print(f"{ip:<16}: Timeout")
        else:
            print(f"{ip:<16}: {latency:.2f} ms")

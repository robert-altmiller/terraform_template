import re, glob
from collections import Counter

# =====================
# Resource Type Summary
# =====================
resource_types = []
for file in glob.glob("./exporter_results/*.tf"):
    with open(file) as f:
        for line in f:
            m = re.match(r'\s*resource\s+"([^"]+)"', line)
            if m:
                resource_types.append(m.group(1))

resource_summary = Counter(resource_types)

# Manual formatting (left aligned)
print("# =====================")
print("# Resource Type Summary")
print("# =====================")
print(f"{'Resource Type':<35} {'Count':<5}")
for r, c in sorted(resource_summary.items()):
    print(f"{r:<35} {c:<5}")

# =====================
# Identity Summary
# =====================
groups, users, sps = set(), set(), set()

for file in glob.glob("./exporter_results/*.tf"):
    with open(file) as f:
        for line in f:
            if "group_id" in line:
                m = re.search(r'data\.databricks_group\.([^.]+)', line)
                if m:
                    groups.add(m.group(1))
            if "member_id" in line:
                mu = re.search(r'data\.databricks_user\.([^.]+)', line)
                ms = re.search(r'data\.databricks_service_principal\.([^.]+)', line)
                if mu:
                    users.add(mu.group(1))
                if ms:
                    sps.add(ms.group(1))

identity_summary = {
    "Unique Groups": len(groups),
    "Unique Users": len(users),
    "Unique Service Principals": len(sps)
}

print("\n# =====================")
print("# Identity Summary")
print("# =====================")
print(f"{'Type':<35} {'Count':<5}")
for k, v in identity_summary.items():
    print(f"{k:<35} {v:<5}")

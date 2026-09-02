# Repository settings proposal

This file **proposes** changes to GitHub repository settings. It does not apply
them. Repository and organization settings are the founder's to change, so
treat every item below as a recommendation waiting on a decision.

Written during the org-wide repository hygiene sweep on 2026-09-01.

## What this repository is

20EQ is a demonstration program: a Halloween-themed command-line game written in
Harn, published to show what a complete Harn application looks like. Nothing
depends on it and it has no users to keep compatible.

Its commit history looks busier than its development actually is. Of the last
hundred or so pull requests, nearly all are automated Harn runtime bumps and
fleet projection restores. The last human change to the game itself was the
refactor onto Harn primitives in pull request #16. Read the activity as a live
dependency treadmill, not as active product development.

The repository has no stars, forks, external pull requests, or issues.

## Proposed changes

| Setting | Today | Proposed | Why |
| --- | --- | --- | --- |
| Issues | Enabled | **Keep enabled** | A demo that does not run has failed at its only job, and someone hitting that needs a way to say so. |
| Discussions | Disabled | Keep disabled | Questions about the language belong in `burin-labs/harn`. |
| Wiki | Check and disable if enabled | Disabled | The README is the documentation, and it is complete. |
| Projects | Check and disable if enabled | Disabled | No planning happens here. |
| Pull requests from non-members | Allowed | Allowed | Unlike the vendored grammar wrappers, there is no supply-chain surface to protect. A drive-by fix to a demo is cheap to review and cheap to decline. |
| Branch protection on `main` | Verify | Require the CI status check and a pull request | The automated bump lane pushes here constantly. A required check is what keeps a bad bump off `main`. |
| Merge strategy | Verify | Squash only, delete branch on merge | Keeps the bump history one commit per bump. |

## Worth a decision

The automated Harn runtime bump lane spends real CI minutes keeping a demo
current, and it accounts for almost all activity in this repository. That is
defensible if the demo doubles as a canary that catches breaking Harn changes
against a full application. If it is not serving that purpose, the bump cadence
here is a cost with no return, and slowing it to a periodic manual refresh would
reclaim it. This is a founder call, not a hygiene change.

## Deliberately not proposed

- **Archiving.** The demo is current and works. Archiving would signal
  abandonment and stop the bump lane that keeps it building.

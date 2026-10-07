# Final Reflection – CCM101 Cloud Computing

**Student:** Angel Crisedio Fernandez
**Section:** BSIT 2A
**Instructor:** Jenkielyn C. Torres
**Date:** October 2026

---

## From Mission 1 to Mission 10: A Cloud Journey

I need to be honest about this reflection, because anything less
wouldn't be true.

Last year, in the middle of the semester, my mother passed away on
September 30. I was in CCM101 at the time, and after that, I could not
focus on anything. I became an irregular student. I stopped submitting.
I stopped being the kind of student who finishes things.

By finals, I was already far behind. Our professor gave the whole class
a second chance — a single day to record and upload videos of
Laboratory Activities 4 through 10 for completion. It was a fair offer
to everyone. But for me, it landed at the worst possible time.

It was capstone week. I hadn't slept properly in days. And I was still
grieving. But I did the work. I sat down, I recorded all seven videos,
and I finished them. When I tried to upload them, my internet
connection dropped. I tried again. It died again. I tried again. It
died again. By the time the day ended, I had the videos on my laptop
and no way to get them to my professor.

I had done the work. I just couldn't prove it.

So I let CCM101 fail. I told myself: *I'll retake it when I'm ready.
When I can actually finish.*

That day was not the day. But this is.

Mission 10 — The Enterprise Cloud Architect — is not just a lab
activity to me. It is the proof that I can close a chapter that grief
and bad internet tried to leave open.

### The Hardest Part Was Not The Code

The hardest part was **starting again**.

When you've been away from something for a while, especially after
grief, the first hour back is brutal. I opened VirtualBox and stared at
a blank VM. I didn't remember how half of it worked. I had to relearn
networking from scratch.

Then I hit a wall. My Ubuntu VM had no IP address. I spent hours
staring at a blank `hostname -I` output, switching between Bridged
Adapter and NAT, adding port forwarding rules, and testing SSH over
and over until it finally worked. That was the first time in months
I felt like myself again — because I was solving a problem, and the
solution was mine.

The second wall was MySQL 8.0 and WordPress. "Error establishing a
database connection" became the phrase of my week. I learned about
`caching_sha2_password` vs `mysql_native_password`, wrote my first
`init.sql` script, and watched WordPress finally load in my browser.
That moment — the WordPress welcome page showing up on
`localhost:8080` — was the first real win I'd had in a long time.

### Why I Failed The First Time

I want to write this down clearly, because it matters.

When my mother passed away in September, I stopped being able to
function the way a student is supposed to. I couldn't concentrate. I
couldn't sit through lectures. I couldn't bring myself to open my
laptop and do the work. Grief takes up all the space in your head.

By the time finals came around, I was already behind on everything. The
one-day window our professor gave the class was generous — I know that.
But I wasn't in a place to record seven videos and upload them in a
single day, and my internet failed every time I tried anyway.

And here's the part that still bothers me: I *did* record all seven
videos. I finished them. The work was done. But when it came time to
upload, my internet connection dropped and never came back. I couldn't
submit. I couldn't prove I had done anything.

I failed CCM101 not because I didn't do the work — but because I
couldn't turn it in. That's a different kind of failure, and honestly,
it hurt more. It made me feel like all that effort meant nothing.

But it didn't. Because I'm here now, doing it again. And this time, it
counts.

### Doing It Alone

I also need to mention this, because it made everything harder.

When I became an irregular student, I got separated from my friends.
They were moved to a different block. The block I ended up in was full
of people I didn't know. I had no one to ask when my VM wouldn't boot.
No one to complain to when the MySQL error kept appearing. No group
chat to fall back on. No classmate to compare screenshots with.

I finished this entire project essentially alone. Every error message,
I read it myself. Every fix, I found it myself. Every time I wanted to
give up, there was nobody around to tell me to keep going, so I had to
tell myself.

I'm not saying this to ask for sympathy. I'm saying it because it's
part of the truth of how this mission was completed. And looking back,
I think it made me a better architect — because an architect, by
definition, is the person who figures things out when nobody else can.

### What I Actually Learned

**1. Cloud infrastructure is about decisions, not commands.**
Anyone can copy-paste a `docker-compose.yml` file. The architect is the
one who decides *why* NAT over Bridged, *why* volumes over bind mounts,
*why* UFW rules for exactly 22 and 8080 and nothing else. That mindset
is the actual skill.

**2. Security is layered, and so is recovery.**
UFW isn't enough on its own. Docker network isolation isn't enough on
its own. Separate DB credentials aren't enough. My backup script runs
at 2 AM every day because a real system doesn't wait for a human to
press "backup." It just does it.

**3. Documentation is an act of care.**
Writing the operational manual was harder than building the stack. But
I wrote it because someone else might need it someday — a classmate, a
future coworker, or just future me if I ever have to rebuild this from
scratch.

**4. You can come back.**
This is the one I didn't expect to learn from a Cloud Computing class.
I came into Mission 10 irregular, grieving, having failed the subject
the first time, and doing it alone. I'm leaving it with a running
enterprise infrastructure, a working WordPress site, a secured
firewall, and a script that backs up my database at 2 AM while I sleep.

Not because I'm smart. Because I showed up, one problem at a time,
until there were no problems left.

### What I'd Do Differently

If I could redo Mission 10:

- **I'd accept help sooner.** I tried to fight every issue alone for
  too long. A single question to a classmate would have saved me hours.
- **I'd screenshot as I went.** I had to rebuild parts of my
  documentation from memory.
- **I'd start with the easiest requirements first.** Momentum matters.
- **I'd stop apologizing for being slow.** Grief slows you down.
  That's not a character flaw. It's a season. This season ended.

### Closing Thought

The mission brief said: *"An Architect does not follow a manual; they
write it."*

I thought that was about technical skill. Now I think it's about
something else — it's about being the person who decides what happens
next, instead of waiting for life to decide for them.

I failed CCM101 the first time. I lost my mother. I became an irregular
student. My friends were in a different block. I recorded every video
and then couldn't upload a single one. And I'm still here, submitting
Mission 10.

Not because I'm stronger than anyone else. Because finishing became a
way of honoring her. I don't know if she'd understand what a
`docker-compose.yml` file is, but I know she'd be proud that I didn't
quit.

Cloud computing taught me how to run servers, secure networks, and
automate backups. It also taught me, quietly and unexpectedly, how to
come back from the worst year of my life.

**Guiding Principle Applied:** *Be the pilot of AI, not the passenger.*
I used AI tools to help me debug and understand, but every command,
every test, and every decision was mine. I own this work. And honestly,
I'm proud of it.

---

*In memory of my mother.*
*September 30, 2025.*

---

*End of Reflection*

# Final Reflection – CCM101 Cloud Computing

**Student:** Angel Crisedio Fernandez
**Section:** BSIT 4I
**Instructor:** Jenkielyn C. Torres
**Date:** October 2026

---

## From Mission 1 to Mission 10: A Cloud Journey

Last year, my mother passed away on September 30. I was in the middle
of exams — not just CCM101, but everything. After that, I couldn't
focus on anything. I became an irregular student. I stopped
submitting. I stopped finishing things.

By finals, I was far behind. Our professor gave the class a second
chance — one day to record and upload Labs 4 through 10. It was
capstone week. I hadn't slept. I was still grieving. But I recorded
all seven videos. When I tried to upload them, my internet dropped.
Again. And again. By the end of the day, the videos were on my laptop
and nowhere else.

I had done the work. I just couldn't prove it.

So I let CCM101 fail. I told myself I'd retake it when I was ready.

That day was not the day. But this is.

Mission 10 is not just a lab activity to me. It is proof that I can
close a chapter that grief and bad internet tried to leave open.

### The Hardest Part Was Not The Code

The hardest part was **starting again**.

I opened VirtualBox and stared at a blank VM. My Ubuntu VM had no IP
address. I spent hours switching between Bridged Adapter and NAT,
adding port forwarding rules, testing SSH until it finally worked.
That was the first time in months I felt like myself again.

Then came MySQL 8.0 and WordPress. "Error establishing a database
connection" became the phrase of my week. I learned about
`caching_sha2_password`, wrote my first `init.sql` script, and watched
WordPress finally load at `localhost:8080`. That was the first real
win I'd had in a long time.

### Why I Failed The First Time

When my mother passed, I stopped being able to function the way a
student is supposed to. I was in the middle of exams for all my
subjects, not just CCM. Grief takes up all the space in your head.
The one-day window our professor gave was generous, but I wasn't in a
place to record seven videos and upload them in a single day. And my
internet failed every time I tried anyway.

I did record all seven videos. The work was done. But I couldn't turn
it in. That's a different kind of failure, and it hurt more. It made
me feel like all that effort meant nothing.

But it didn't. Because I'm here now, doing it again. And this time,
it counts.

### Doing It Alone

When I became an irregular student, I got separated from my friends.
The block I ended up in was full of people I didn't know. No one to
ask when my VM wouldn't boot. No one to complain to when MySQL kept
failing. No group chat to fall back on.

I finished this entire project essentially alone. Every error message,
I read it myself. Every fix, I found it myself. Every time I wanted to
give up, there was nobody around to tell me to keep going, so I had
to tell myself.

I'm not saying this for sympathy. I'm saying it because it's part of
the truth. And looking back, I think it made me a better architect —
because an architect is the person who figures things out when nobody
else can.

### What I Actually Learned

**1. Cloud infrastructure is about decisions, not commands.**
Anyone can copy-paste a `docker-compose.yml`. The architect decides
*why* NAT over Bridged, *why* volumes over bind mounts, *why* UFW
rules for exactly 22 and 8080.

**2. Security is layered, and so is recovery.**
UFW isn't enough alone. Docker isolation isn't enough alone. My backup
script runs at 2 AM every day because a real system doesn't wait for
a human.

**3. Documentation is an act of care.**
Writing the operational manual was harder than building the stack. I
wrote it because someone else might need it someday.

**4. You can come back.**
I came into Mission 10 irregular, grieving, having failed the
subject, and alone. I'm leaving it with a running enterprise
infrastructure, a working WordPress site, a secured firewall, and a
script that backs up my database at 2 AM while I sleep. Not because
I'm smart. Because I showed up, one problem at a time, until there
were no problems left.

### What I'd Do Differently

- **Accept help sooner.** A single question could have saved me hours.
- **Screenshot as I went.** I rebuilt documentation from memory.
- **Start with the easiest requirements first.** Momentum matters.
- **Stop apologizing for being slow.** Grief slows you down. That's
  not a flaw. It's a season. This season ended.

### Closing Thought

The mission brief said: *"An Architect does not follow a manual; they
write it."*

I thought that was about technical skill. Now I think it's about
something else — it's about being the person who decides what happens
next, instead of waiting for life to decide for them.

I failed CCM101 the first time. I lost my mother. I became an
irregular student. I recorded every video and couldn't upload a
single one. And I'm still here, submitting Mission 10.

Not because I'm stronger than anyone else. Because finishing became a
way of honoring her. I don't know if she'd understand what a
`docker-compose.yml` is, but I know she'd be proud that I didn't quit.

Cloud computing taught me how to run servers, secure networks, and
automate backups. It also taught me, quietly and unexpectedly, how to
come back from the worst year of my life.

**Guiding Principle Applied:** *Be the pilot of AI, not the passenger.*
I used AI tools — one in particular became my debug buddy during late
nights — to help me understand errors and think through problems. But
every command, every test, and every decision was mine. I own this
work. And honestly, I'm proud of it.

---

*End of Reflection*



# Final Reflection – CCM101 Cloud Computing

**Student:** Delmonte, Marlon Jay P.
**Year & Section:** BSIT 4-I

---

Throughout my time in Cloud Computing, I learned a lot about Linux,
virtual machines, Docker, networking, security, and automation. At
first, some tasks were hard. As I kept learning, I started to
understand how these technologies fit together.

In our activity **Mission 10: The Enterprise Cloud Architect**, I
learned how important it is to plan and create a secure and working
cloud setup. Setting up Ubuntu Server, Docker, and Docker Compose
helped me see how applications can run in containers. I also learned
how important it is to have storage so data stays safe and available
even after a server restarts.

Another thing I learned was how important security and automation are.
Setting up the firewall showed me how to keep a server safe from
people who shouldn't access it. Bash scripts and Cron jobs showed me
how to make tasks like backups and checking the system happen
automatically. I also realized that good documentation and keeping
files organized in GitHub are important for keeping a project running
smoothly.

Overall, this activity helped me use the knowledge I got from lab
work. It taught me to be more patient, to work on my own, and to find
solutions when things go wrong. Even though there were some problems
along the way, I realized that learning cloud computing needs practice
and being ready to learn from mistakes. This experience made me want
to keep getting better at cloud computing, DevOps, and system
administration, which I hope to use in my job in Information
Technology.

---

*End of Reflection*


# Reflection Paper: Mission 10 – The Enterprise Cloud Architect

**Student:** Micu, Ralph Lourene M.
**Year & Section:** BSIT 4-I
**Course:** CCM101 – Cloud Computing | Laboratory Activity 10

---

When I completed Laboratory Activity 10, I realized how much I learned
throughout CCM101 – Cloud Computing. This activity helped me
understand how different technologies work together to build a
complete cloud system.

For my project, I imagined using WordPress and MySQL on an Ubuntu
Server virtual machine with Docker and Docker Compose. I also learned
the importance of persistent storage to protect data, configuring UFW
to secure the server, and using a Bash script with Cron to automate
database backups.

This activity also taught me the importance of proper documentation.
By organizing my files in GitHub, I could provide instructions for
deploying, securing, and maintaining the system. I also understood
that testing and troubleshooting are necessary to make sure everything
works correctly.

Overall, this activity helped me connect my knowledge of Linux,
virtualization, networking, security, and automation. I learned that
cloud computing is not just about running an application but also
about keeping it secure, reliable, and easy to maintain. This
experience gave me a better understanding of the responsibilities of a
cloud architect.

---

*End of Reflection*


# Reflection Paper: Mission 10 – The Enterprise Cloud Architect

**Student:** Roldan, John Henry S.
**Year & Section:** BSIT 4-I
**Course:** CCM101 – Cloud Computing | Laboratory Activity 10

---

When I completed Laboratory Activity 10, I gained a better
understanding of how different cloud computing technologies work
together to create a complete and functional system. This activity
helped me appreciate the importance of planning, configuring, and
managing cloud infrastructure properly.

For my project, I explored the use of WordPress and MySQL on an Ubuntu
Server virtual machine using Docker and Docker Compose. I learned how
containers make application deployment easier and more organized. I
also realized the importance of persistent storage in protecting data,
configuring UFW to improve server security, and using Bash scripts
with Cron to automate database backups.

This activity also taught me the importance of proper documentation
and system management. By organizing my project files in GitHub, I
learned how to provide clear instructions for deploying, securing,
and maintaining the system. I also understood that testing and
troubleshooting are important steps to ensure that all components work
correctly and efficiently.

Overall, this laboratory activity helped me connect my knowledge of
Linux, virtualization, networking, security, and automation. I learned
that cloud computing is not only about running applications but also
about making systems secure, reliable, and easy to maintain. This
experience improved my understanding of the responsibilities of an
enterprise cloud architect and the importance of designing and
managing an effective cloud-based system.

---

*End of Reflection*

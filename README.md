# Homecare

# Inspiration
One of my friends suffered an injury during his ultimate frisbee game. I accompanied him to the doctors, where he was being diagnosed by a family practice physician. She performed a series of tests, pulling and pushing his legs in certain angles and soliciting a response from him. While watching her do this, I begin to see a binary tree.

# What it does
Homecare is an app that allows patients to learn more about a musculoskeletal injury they may be suffering. It prompts the user in engaging in several, simple physical exams, and then records whether the patient felt a lot of pain, some pain, or no pain through voice recognition technology. In the background, the app is calculating a score for a large variety of common injuries, and once all the questions are answered, it presents the injury with the highest score. Furthermore, users are then able to locate providers nearby using the BetterDoctor API.

# How we built it
We initially had goals to create an Amazon Alexa app. But we swiftly (haha, get it) pivoted to an iOS-focused application. We built the entire front-end using Xcode and Swift. We utilized several libraries provides by the iOS-SDK, such as Speech and AVPlayer. Additionally, our team had to conduct thorough research on common musculoskeletal injuries of the ankle and the knee. We had to compile tentative score values for each exam and even consulted with a medical student to refine our findings. Lastly, we used the BetterDoctor API to provide our locate physician functionality, using a Node.js server.

# Challenges we ran into
We had a great deal of trouble trying to integrate Amazon Alexa and iOS. We also had difficulty navigating through the dense amounts of information on the web related to ankle and knee injuries. Determining the score values and percentage match required some computation and thought.

# Accomplishments that we're proud of
I am proud of my team, who all did a phenomenal job. All three members had never been to a hackathon before this one, and they were very relentless in their work ethic and pleasure to be around. We all learned from each other and truly had a good time, even with all of our frustrating bugs and challenges. I am also proud to have worked on my first Healthcare Hack. It feels good knowing that our team has paved the way to help people!

# What we learned
I learned more about server and client-side interactions, along with voice recognition and lambda functions. Additionally, I strengthened my knowledge of Swift, especially in Enumerations, which I used heavily to implement the Object Oriented design.

# What's next for Homecare
Something else we were looking to do was to add a machine learning aspect to the application. Users would be prompted a week after their initial assessment to record whether or not the assessment was accurate. Depending on the user's answers, the score values of each question could be tweaked to provide a better framework to identify injuries.

Write Good Documentation

Documentation tells people what the software or code does, how to install it, how they can use it, and it provides a working example and contribution guides.

Note that even though the code is an open-source project, it still needs to have a license to let other people use, alter, or make additions within the defined scope. So, documentation is basically a rulebook or a guide to help people use your software.


Source

Incomplete documentation will make it difficult for people to get the gist and purpose of your code, making them hesitant to try it out no matter how good your project is.

So just make sure you have well-written documentation, along with any details about all the latest changes you've made to the project.
Automate Repetitive Tasks

Maintaining an open source project will typically involve many tasks that are repetitive, like scheduled maintenance, periodic updating of dependencies, continuous integration, and so forth.

Since these tasks are time-consuming, repetitive, and require no innovation, you can automate many of them.

Take updating dependencies, for example. It is common to make use of other packages and dependencies in your projects. But, at the same time, you can't afford to compromise your project's security/performance by using a dependency that is obsolete.

One tool that I find useful for this is the free WhiteSource Renovate. It automates dependency updates. So using a tool like Renovate to keep dependencies updated is a crucial task you shouldn't neglect. If you want to learn how to integrate WhiteSource Renovate into your project, continue reading the below section.
Automatic dependency updating with Renovate

Firstly, you'll need to integrate Renovate with your GitHub account. Then click install, and follow the steps as instructed.

While configuring, Renovate lets you decide if it should run on all the repositories by default or only on specific repositories. Select the option as you wish. (Note: If you want to Renovate to run on forked repositories, clicking Select All Repositories will skip forked repos by default. In such cases, you’ll have to manually add the forked repo(s)).

Soon after setting up Renovate with the required repositories, an onboarding PR will be submitted by the Renovate bot, which contains information like configuration summary and what packages/dependencies are supposed to be upgraded.

For demonstration purposes, I've forked a repo from my GitHub account that is supposedly a mobile application built on React Native. It is no longer maintained, so it'll serve as a good example to test on.


Once you merge the above pull request, the Renovate bot will start looking for outdated or stale dependencies that need to be updated and submit a PR for each dependency that needs to be updated.

Keep in mind that this tool doesn't trace vulnerabilities or issues, only available updates. But new dependencies often come with bug fixes, security improvements, and newly-added features.

Still, just because there's an update available doesn't mean you have to update it because chances are it might break your existing system due to a compatibility mismatch or something similar. So it's important to review the update before merging the PR.

To help you make sound decisions regarding whether you want to upgrade a package or not, the PR includes details about the adoption rate and test passing rate, which effectively determines the overall confidence level.

It also pulls the latest release notes from the dependency repository, which would otherwise require you to manually navigate to the repo to find what's new.

Always Address Issues

One good way to make sure that your project continuously improves is to address issues opened by your peers.

No one will show interest in contributing to an open-source project if it doesn't address potential bugs, security issues, or feature addition.

You can set up a CI script that assigns a label when an issue is opened and then assign it to the contributors maintaining the project accordingly. This will result in issues being reviewed at a rapid rate and will also help contributors find new fixes and/or feature additions.
Spread the Word About Your Project

You've published an excellent open source project, yet you don't see anyone using or contributing to the project. The primary reason for this could be that people haven't found out about your project.

To get the ball rolling, you should make sure your project gets all the exposure it can. One effective way to do this is by sharing your work on social media, wherever people are active who might be interested in it.

You can also get involved in discussions on topics related to your projects on Q&A platforms, like Stack Overflow and Reddit. Then sharing your project will be a natural thing to do.
Attract Helpful Contributors

Following the above steps will help you get started. But once your project starts growing, it’ll need more contributors that are willing to maintain the project.

This is only possible when you build up a strong contributor base. To increase the people helping you maintain the project, you can set up rewards for contributions, like giving out swag to people who satisfy certain requirements.

People will also be encouraged to contribute if they feel a sense of pride and ownership of the project. So make sure everyone gets due credit for their contributions, big or small.

Positive actions like this can also potentially enable new contributors to share their work with their friends/colleagues, indirectly helping your project gain more exposure/users/contributors.
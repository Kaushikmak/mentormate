<div id="top">

<!-- HEADER STYLE: CLASSIC -->
<div align="center">

<img src="readmeai/assets/logos/purple.svg" width="30%" style="position: relative; top: 0; right: 0;" alt="Project Logo"/>

# MENTORMATE

<em>Connecting Mentors and Mentees for a Seamless Campus Experience</em>

<!-- BADGES -->
<img src="https://img.shields.io/github/license/Kaushikmak/mentormate?style=default&logo=opensourceinitiative&logoColor=white&color=0080ff" alt="license">
<img src="https://img.shields.io/github/last-commit/Kaushikmak/mentormate?style=default&logo=git&logoColor=white&color=0080ff" alt="last-commit">
<img src="https://img.shields.io/github/languages/top/Kaushikmak/mentormate?style=default&color=0080ff" alt="repo-top-language">
<img src="https://img.shields.io/github/languages/count/Kaushikmak/mentormate?style=default&color=0080ff" alt="repo-language-count">

<!-- default option, no dependency badges. -->


<!-- default option, no dependency badges. -->

</div>
<br>

---

## Table of Contents

- [Table of Contents](#table-of-contents)
- [Overview](#overview)
- [Features](#features)
- [Project Structure](#project-structure)
    - [Project Index](#project-index)
- [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
    - [Usage](#usage)
    - [Testing](#testing)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgments](#acknowledgments)

---

## Overview

MentorMate is an Android/iOS application built with Firebase, designed to connect mentors (seniors) with mentees (juniors). This app aims to provide a comprehensive platform for students, integrating features like a custom Google Campus Map, personalized schedules, secure login, and information on clubs and extracurricular activities, all in one place.

**Note:** This project is currently under maintenance and is not yet completed.

---

## Features

- **Mentor-Mentee Connection:** Connects senior students with junior students for mentorship.
- **Custom Google Campus Map:** Integrated campus map for easy navigation.
- **Customized Schedule:** Allows students to create and manage personalized schedules.
- **Login:** Secure login functionality for user authentication.
- **Clubs:** Provides information and resources related to various campus clubs.
- **All-in-One Platform:** Combines essential student resources in a single application.

---

## Project Structure

└── mentormate/
├── README.md
├── analysis_options.yaml
├── android
│ ├── .gitignore
│ ├── app
│ ├── build.gradle.kts
│ ├── gradle
│ ├── gradle.properties
│ └── settings.gradle.kts
├── assets
│ ├── faqs.json
│ ├── first_year_timetable.json
│ ├── fourth_year_timetable.json
│ ├── images
│ ├── mentor_details.json
│ ├── second_year_timetable.json
│ ├── third_year_timetable.json
│ └── user.png
├── devtools_options.yaml
├── ios
│ ├── .gitignore
│ ├── Flutter
│ ├── Runner
│ ├── Runner.xcodeproj
│ ├── Runner.xcworkspace
│ └── RunnerTests
├── lib
│ ├── caching
│ ├── main.dart
│ ├── map
│ ├── messge_handler
│ ├── models
│ ├── providers
│ ├── repositories
│ ├── screens
│ └── services
│ └── widgets
├── pubspec.lock
├── pubspec.yaml
└── test
└── widget_test.dart

text

### Project Index
<details open>
	<summary><b><code>MENTORMATE/</code></b></summary>
	<!-- __root__ Submodule -->
	<details>
		<summary><b>__root__</b></summary>
		<blockquote>
			<div class='directory-path' style='padding: 8px 0; color: #666;'>
				<code><b>⦿ __root__</b></code>
			<table style='width: 100%; border-collapse: collapse;'>
			<thead>
				<tr style='background-color: #f8f9fa;'>
					<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
					<th style='text-align: left; padding: 8px;'>Summary</th>
				</tr>
			</thead>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/pubspec.yaml'>pubspec.yaml</a></b></td>
					<td style='padding: 8px;'>Configuration file for Flutter projects, specifying dependencies and project metadata.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/devtools_options.yaml'>devtools_options.yaml</a></b></td>
					<td style='padding: 8px;'>Configuration file for Dart DevTools, specifying settings for debugging and profiling.</td>
				</tr>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/analysis_options.yaml'>analysis_options.yaml</a></b></td>
					<td style='padding: 8px;'>Configuration file for Dart static analysis, defining rules and guidelines for code quality.</td>
				</tr>
			</table>
		</blockquote>
	</details>
	<!-- test Submodule -->
	<details>
		<summary><b>test</b></summary>
		<blockquote>
			<div class='directory-path' style='padding: 8px 0; color: #666;'>
				<code><b>⦿ test</b></code>
			<table style='width: 100%; border-collapse: collapse;'>
			<thead>
				<tr style='background-color: #f8f9fa;'>
					<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
					<th style='text-align: left; padding: 8px;'>Summary</th>
				</tr>
			</thead>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/test/widget_test.dart'>widget_test.dart</a></b></td>
					<td style='padding: 8px;'>Basic widget test file for Flutter applications.</td>
				</tr>
			</table>
		</blockquote>
	</details>
	<!-- lib Submodule -->
	<details>
		<summary><b>lib</b></summary>
		<blockquote>
			<div class='directory-path' style='padding: 8px 0; color: #666;'>
				<code><b>⦿ lib</b></code>
			<table style='width: 100%; border-collapse: collapse;'>
			<thead>
				<tr style='background-color: #f8f9fa;'>
					<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
					<th style='text-align: left; padding: 8px;'>Summary</th>
				</tr>
			</thead>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/main.dart'>main.dart</a></b></td>
					<td style='padding: 8px;'>Entry point of the Flutter application, responsible for initializing and running the app.</td>
				</tr>
			</table>
			<!-- caching Submodule -->
			<details>
				<summary><b>caching</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ lib.caching</b></code>
					<table style='width: 100%; border-collapse: collapse;'>
					<thead>
						<tr style='background-color: #f8f9fa;'>
							<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
							<th style='text-align: left; padding: 8px;'>Summary</th>
						</tr>
					</thead>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/caching/avatar_cache_manager.dart'>avatar_cache_manager.dart</a></b></td>
							<td style='padding: 8px;'>Manages the caching of user avatars in the application.</td>
						</tr>
					</table>
				</blockquote>
			</details>
			<!-- widgets Submodule -->
			<details>
				<summary><b>widgets</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ lib.widgets</b></code>
					<table style='width: 100%; border-collapse: collapse;'>
					<thead>
						<tr style='background-color: #f8f9fa;'>
							<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
							<th style='text-align: left; padding: 8px;'>Summary</th>
						</tr>
					</thead>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/widgets/mentor_card.dart'>mentor_card.dart</a></b></td>
							<td style='padding: 8px;'>Flutter widget to display mentor information in a card format.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/widgets/custom_drawer.dart'>custom_drawer.dart</a></b></td>
							<td style='padding: 8px;'>A custom-designed drawer widget for Flutter applications.</td>
						</tr>
					</table>
				</blockquote>
			</details>
			<!-- models Submodule -->
			<details>
				<summary><b>models</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ lib.models</b></code>
					<table style='width: 100%; border-collapse: collapse;'>
					<thead>
						<tr style='background-color: #f8f9fa;'>
							<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
							<th style='text-align: left; padding: 8px;'>Summary</th>
						</tr>
					</thead>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/models/user_data.g.dart'>user_data.g.dart</a></b></td>
							<td style='padding: 8px;'>Generated code for serializing and deserializing UserData objects in Dart using `json_serializable`.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/models/user_data.dart'>user_data.dart</a></b></td>
							<td style='padding: 8px;'>Defines the `UserData` model class in Dart, which includes information about a user such as ID, name, email, and profile image.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/models/timetable_entry.dart'>timetable_entry.dart</a></b></td>
							<td style='padding: 8px;'>Code>❯ REPLACE-ME</code></td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/models/faq_item.dart'>faq_item.dart</a></b></td>
							<td style='padding: 8px;'>Code>❯ REPLACE-ME</code></td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/models/extracurricular.dart'>extracurricular.dart</a></b></td>
							<td style='padding: 8px;'>Code>❯ REPLACE-ME</code></td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/models/department.dart'>department.dart</a></b></td>
							<td style='padding: 8px;'>Code>❯ REPLACE-ME</code></td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/models/mentor.dart'>mentor.dart</a></b></td>
							<td style='padding: 8px;'>Code>❯ REPLACE-ME</code></td>
						</tr>
					</table>
				</blockquote>
			</details>
			<!-- providers Submodule -->
			<details>
				<summary><b>providers</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ lib.providers</b></code>
					<table style='width: 100%; border-collapse: collapse;'>
					<thead>
						<tr style='background-color: #f8f9fa;'>
							<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
							<th style='text-align: left; padding: 8px;'>Summary</th>
						</tr>
					</thead>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/providers/theme_provider.dart'>theme_provider.dart</a></b></td>
							<td style='padding: 8px;'>Manages the theme settings of the application.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/providers/auth_provider.dart'>auth_provider.dart</a></b></td>
							<td style='padding: 8px;'>Handles authentication logic in the application.</td>
						</tr>
					</table>
				</blockquote>
			</details>
			<!-- screens Submodule -->
			<details>
				<summary><b>screens</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ lib.screens</b></code>
					<table style='width: 100%; border-collapse: collapse;'>
					<thead>
						<tr style='background-color: #f8f9fa;'>
							<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
							<th style='text-align: left; padding: 8px;'>Summary</th>
						</tr>
					</thead>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/screens/schedule_page.dart'>schedule_page.dart</a></b></td>
							<td style='padding: 8px;'>Code>❯ REPLACE-ME</code></td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/screens/mentors_page.dart'>mentors_page.dart</a></b></td>
							<td style='padding: 8px;'>Code>❯ REPLACE-ME</code></td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/screens/mentor_detail_page.dart'>mentor_detail_page.dart</a></b></td>
							<td style='padding: 8px;'>Code>❯ REPLACE-ME</code></td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/screens/resources_page.dart'>resources_page.dart</a></b></td>
							<td style='padding: 8px;'>Code>❯ REPLACE-ME</code></td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/screens/faq_page.dart'>faq_page.dart</a></b></td>
							<td style='padding: 8px;'>Code>❯ REPLACE-ME</code></td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/screens/settings_page.dart'>settings_page.dart</a></b></td>
							<td style='padding: 8px;'>Code>❯ REPLACE-ME</code></td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/screens/home_page.dart'>home_page.dart</a></b></td>
							<td style='padding: 8px;'>Code>❯ REPLACE-ME</code></td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/screens/user_detail_page.dart'>user_detail_page.dart</a></b></td>
							<td style='padding: 8px;'>Code>❯ REPLACE-ME</code></td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/screens/extracurricular_activities_page.dart'>extracurricular_activities_page.dart</a></b></td>
							<td style='padding: 8px;'>Code>❯ REPLACE-ME</code></td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/screens/department_page.dart'>department_page.dart</a></b></td>
							<td style='padding: 8px;'>Code>❯ REPLACE-ME</code></td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/screens/login_page.dart'>login_page.dart</a></b></td>
							<td style='padding: 8px;'>Code>❯ REPLACE-ME</code></td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/screens/register_page.dart'>register_page.dart</a></b></td>
							<td style='padding: 8px;'>Code>❯ REPLACE-ME</code></td>
						</tr>
					</table>
				</blockquote>
			</details>
			<!-- repositories Submodule -->
			<details>
				<summary><b>repositories</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ lib.repositories</b></code>
					<table style='width: 100%; border-collapse: collapse;'>
					<thead>
						<tr style='background-color: #f8f9fa;'>
							<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
							<th style='text-align: left; padding: 8px;'>Summary</th>
						</tr>
					</thead>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/repositories/user_data_repository.dart'>user_data_repository.dart</a></b></td>
							<td style='padding: 8px;'>Code>❯ REPLACE-ME</code></td>
						</tr>
					</table>
				</blockquote>
			</details>
			<!-- services Submodule -->
			<details>
				<summary><b>services</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ lib.services</b></code>
					<table style='width: 100%; border-collapse: collapse;'>
					<thead>
						<tr style='background-color: #f8f9fa;'>
							<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
							<th style='text-align: left; padding: 8px;'>Summary</th>
						</tr>
					</thead>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/services/auth_service.dart'>auth_service.dart</a></b></td>
							<td style='padding: 8px;'>Code>❯ REPLACE-ME</code></td>
						</tr>
					</table>
				</blockquote>
			</details>
			<!-- map Submodule -->
			<details>
				<summary><b>map</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ lib.map</b></code>
					<table style='width: 100%; border-collapse: collapse;'>
					<thead>
						<tr style='background-color: #f8f9fa;'>
							<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
							<th style='text-align: left; padding: 8px;'>Summary</th>
						</tr>
					</thead>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/map/map_page.dart'>map_page.dart</a></b></td>
							<td style='padding: 8px;'>Code>❯ REPLACE-ME</code></td>
						</tr>
					</table>
				</blockquote>
			</details>
			<!-- messge_handler Submodule -->
			<details>
				<summary><b>messge_handler</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ lib.messge_handler</b></code>
					<table style='width: 100%; border-collapse: collapse;'>
					<thead>
						<tr style='background-color: #f8f9fa;'>
							<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
							<th style='text-align: left; padding: 8px;'>Summary</th>
						</tr>
					</thead>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/lib/messge_handler/app_message_handler.dart'>app_message_handler.dart</a></b></td>
							<td style='padding: 8px;'>Code>❯ REPLACE-ME</code></td>
						</tr>
					</table>
				</blockquote>
			</details>
		</blockquote>
	</details>
	<!-- ios Submodule -->
	<details>
		<summary><b>ios</b></summary>
		<blockquote>
			<div class='directory-path' style='padding: 8px 0; color: #666;'>
				<code><b>⦿ ios</b></code>
			<table style='width: 100%; border-collapse: collapse;'>
			<thead>
				<tr style='background-color: #f8f9fa;'>
					<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
					<th style='text-align: left; padding: 8px;'>Summary</th>
				</tr>
			</thead>
				<tr style='border-bottom: 1px solid #eee;'>
					<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/ios/.gitignore'>.gitignore</a></b></td>
					<td style='padding: 8px;'>Git ignore file for the iOS project, specifying intentionally untracked files that Git should ignore.</td>
				</tr>
			</table>
			<!-- Runner Submodule -->
			<details>
				<summary><b>Runner</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ ios.Runner</b></code>
					<table style='width: 100%; border-collapse: collapse;'>
					<thead>
						<tr style='background-color: #f8f9fa;'>
							<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
							<th style='text-align: left; padding: 8px;'>Summary</th>
						</tr>
					</thead>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/ios/Runner/Configs/AppInfo.xcconfig'>AppInfo.xcconfig</a></b></td>
							<td style='padding: 8px;'>Configuration file for app-specific information in an Xcode project.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json'>Contents.json</a></b></td>
							<td style='padding: 8px;'>JSON file that lists the different sizes and resolutions of the app icon for various iOS devices.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/ios/Runner/AppDelegate.swift'>AppDelegate.swift</a></b></td>
							<td style='padding: 8px;'>The application delegate for the iOS app, handling app lifecycle events.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/ios/Runner/Info.plist'>Info.plist</a></b></td>
							<td style='padding: 8px;'>Property list file that contains essential configuration information for an iOS app.</td>
						</tr>
					</table>
				</blockquote>
			</details>
			<!-- Flutter Submodule -->
			<details>
				<summary><b>Flutter</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ ios.Flutter</b></code>
					<table style='width: 100%; border-collapse: collapse;'>
					<thead>
						<tr style='background-color: #f8f9fa;'>
							<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
							<th style='text-align: left; padding: 8px;'>Summary</th>
						</tr>
					</thead>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/ios/Flutter/AppFrameworkInfo.plist'>AppFrameworkInfo.plist</a></b></td>
							<td style='padding: 8px;'>Property list file that provides information about the Flutter framework in an iOS app.</td>
						</tr>
					</table>
				</blockquote>
			</details>
			<!-- Runner.xcodeproj Submodule -->
			<details>
				<summary><b>Runner.xcodeproj</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ ios.Runner.xcodeproj</b></code>
					<table style='width: 100%; border-collapse: collapse;'>
					<thead>
						<tr style='background-color: #f8f9fa;'>
							<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
							<th style='text-align: left; padding: 8px;'>Summary</th>
						</tr>
					</thead>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/ios/Runner.xcodeproj/project.pbxproj'>project.pbxproj</a></b></td>
							<td style='padding: 8px;'>Xcode project file that contains build settings, file references, and other project-related information.</td>
						</tr>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme'>Runner.xcscheme</a></b></td>
							<td style='padding: 8px;'>Xcode scheme file that defines build and run settings for the app.</td>
						</tr>
					</table>
				</blockquote>
			</details>
			<!-- Runner.xcworkspace Submodule -->
			<details>
				<summary><b>Runner.xcworkspace</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ ios.Runner.xcworkspace</b></code>
					<table style='width: 100%; border-collapse: collapse;'>
					<thead>
						<tr style='background-color: #f8f9fa;'>
							<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
							<th style='text-align: left; padding: 8px;'>Summary</th>
						</tr>
					</thead>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/ios/Runner.xcworkspace/contents.xcworkspacedata'>contents.xcworkspacedata</a></b></td>
							<td style='padding: 8px;'>Workspace data file that specifies the project's workspace settings in Xcode.</td>
						</tr>
					</table>
				</blockquote>
			</details>
			<!-- RunnerTests Submodule -->
			<details>
				<summary><b>RunnerTests</b></summary>
				<blockquote>
					<div class='directory-path' style='padding: 8px 0; color: #666;'>
						<code><b>⦿ ios.RunnerTests</b></code>
					<table style='width: 100%; border-collapse: collapse;'>
					<thead>
						<tr style='background-color: #f8f9fa;'>
							<th style='width: 30%; text-align: left; padding: 8px;'>File Name</th>
							<th style='text-align: left; padding: 8px;'>Summary</th>
						</tr>
					</thead>
						<tr style='border-bottom: 1px solid #eee;'>
							<td style='padding: 8px;'><b><a href='https://github.com/Kaushikmak/mentormate/blob/master/ios/RunnerTests/Info.plist'>Info.plist</a></b></td>
							<td style='padding: 8px;'>Property list file containing configuration information for the test target.</td>
						</tr>
					</table>
				</blockquote>
			</

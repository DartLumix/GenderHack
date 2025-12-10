# Gender Hack App

**An app for female students (mid-grade / high school) to find their study path without stereotypes.**

The underlying idea is an application that supports students in choosing their study path, with the primary goal of breaking down stereotypes about personal abilities and aptitudes, focusing on STEM subjects.

## Features

### 1. BIG Minds' Stories
The heart of the app is an interactive story mode. For each "course," a historical figure of reference in the STEM field is presented (e.g., Ada Lovelace, Margherita Hack).
*   **Storytelling**: The character tells their story and guides the user in solving a micro-problem related to their invention or discovery.
*   **Philosophy**: No punitive "wrong answers." The goal is to stimulate curiosity and convey a message of empowerment.

### 2. Dashboard and Data Analysis
A visual dashboard providing insights into the job market and education landscape.
*   **Profiling**: Visually displays the student's aptitude (analytical-rational vs. pragmatic-creative).
*   **Institutional Data**: Highlights current enrollment shortages and gender gaps in various sectors using real datasets.
*   **Charts**: Interactive bar and pie charts to explore data by region, year, and gender.

### 3. Gamification and Community
*   **XP System**: Users collect experience points by interacting with the app.
*   **Social**: Future features include leaderboards and "Kahoot-style" classroom challenges.

### 4. Orientation and Opportunities
*   **Recommendations**: Directs users to high schools or universities based on their interests.
*   **Integration**: Matches study topics with the stories covered in the app.
*   **Incentives**: Highlights scholarships and job opportunities, especially those promoting gender equality.

## Project Structure

*   `lib/main.dart`: Entry point of the application.
*   `lib/models/`: Data models for stories, employees, and enrollments.
*   `lib/screens/`: UI screens (Dashboard, Profile, Courses, Story Mode).
*   `lib/widgets/`: Reusable UI components (Character, Typewriter Text, Charts).

## Getting Started

### Prerequisites
*   [Flutter SDK](https://flutter.dev/docs/get-started/install) (version >=3.3.0)
*   Dart SDK

### Installation

1.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    cd gender_hack
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run the app:**
    ```bash
    flutter run
    ```

## Usage

1.  **Home**: Navigate between the Dashboard and Profile using the bottom navigation bar. Use the central FAB to access Courses.
2.  **Courses**: Select a historical figure (e.g., Ada Lovelace) to start an interactive story.
3.  **Dashboard**: Use filters (Year, Region, Gender) to analyze enrollment and employment data. View data in Table, Bar Chart, or Pie Chart modes.
4.  **Profile**: Track your weekly progress and goals.

---
*Empowering the next generation of women in STEM.*

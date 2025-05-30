# CodeBook for Tidy Dataset

## Data Source
- Dataset: UCI Human Activity Recognition Using Smartphones
- URL: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Variables
- `subject`: Integer, ID of the subject (1-30)
- `activity`: Factor, activity performed (e.g., WALKING, SITTING)
- [List mean/std variables, e.g., `tBodyAcc-mean()-X`, with descriptions]

## Transformations
1. Merged training and test datasets.
2. Extracted mean and standard deviation measurements.
3. Replaced activity codes with descriptive names.
4. Labeled variables descriptively.
5. Created a tidy dataset with averages per subject and activity.

## Units
- Accelerometer and gyroscope data: Standard gravity units (g) and radians/second, respectively.

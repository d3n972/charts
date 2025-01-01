#!/bin/bash

# Define the output HTML file
output_file="index.html"

# Start the HTML file
cat <<EOF > $output_file
<!DOCTYPE html>
<html>
<head>
    <title>Helm Charts Index</title>
    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/@picocss/pico@2.0.6/css/pico.classless.min.css"
        />
</head>
<body>
    <h1>Helm Charts Index</h1>
    <table>
        <tr>
            <th>Name</th>
            <th>Chart Version</th>
            <th>App Version</th>
        </tr>
EOF

# Loop through each Chart.yaml file in the repository
for chart in $(find . -name "Chart.yaml"); do
    name=$(yq e '.name' $chart)
    chart_version=$(yq e '.version' $chart)
    app_version=$(yq e '.appVersion' $chart)

    # Append the chart information to the HTML file
    cat <<EOF >> $output_file
        <tr>
            <td>$name</td>
            <td>$chart_version</td>
            <td>$app_version</td>
        </tr>
EOF
done

# End the HTML file
cat <<EOF >> $output_file
    </table>
</body>
</html>
EOF

echo "HTML index page generated at $output_file"
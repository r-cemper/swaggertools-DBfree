Class ZX.dbSizeViewer Extends %CSP.Page
{
Parameter Title As STRING [ Final ] = "DB Free size";
Parameter APPLICATION = "DB Free size";
Parameter CATEGORY = "Monitoring";
ClassMethod OnPage() As %Status
{
	Do ..OnPageCSPROOT()
	Return $$$OK
}
ClassMethod OnPageCSPROOT() As %Boolean
{
	Do ..OnPageHTML()
}
ClassMethod OnPageHTML() As %Boolean
{
	Write "<html>"
	Write !
	Do ..OnPageHEAD()
	Do ..OnPageBODY()
	Write !,"</html>"
	Return $$$OK
}
ClassMethod OnPageHEAD() As %Boolean
{
	Write "<head>",!
	Write "<meta charset=""UTF-8"">"
	write "<meta name=""viewport"" content=""width=device-width, initial-scale=1.0"">"
	Write "<link rel=""shortcut icon"" href=""portal/ISC_IRIS_icon.ico"">"
	Write !,"<title>"_..#Title_"</title>",!
	Write " <link rel=""stylesheet"" href=""https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"">",!
	W "<!-- External Libraries -->"
	W "<script src=""https://cdn.jsdelivr.net/npm/chart.js""></script>"
	Write " <script src=""https://cdn.jsdelivr.net/npm/chartjs-plugin-zoom""></script>"
	W "<link rel=""stylesheet"" href=""https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"">"
	Write "<style>",!
	Do ..LoadCSS()
	Write "</style>",!
	Write "</head>",!
	W ..HyperEventHead(0,0)
	Return $$$OK
}
ClassMethod OnPageBODY() As %Boolean
{
	Do ..RenderChart()
	Return $$$OK
}
ClassMethod RenderChart() As %Status
{
	&HTML<
<meta name="viewport" content="width=device-width, initial-scale=1.0"><link rel="shortcut icon" href="portal/ISC_IRIS_icon.ico">
<title>DB Free size</title>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!-- External Libraries --><script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-zoom"></script><link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<script language="JavaScript" type="text/javascript" src="/csp/broker/cspxmlhttp.js"></script><script language="JavaScript" type="text/javascript" src="/csp/broker/cspbroker.js"></script>
    <header>
        <div class="container">
            <h1><i class="fas fa-database"></i> DB Free size</h1>
        </div>
    </header>
    <div class="container">
        <!-- Namespace Selector -->
        <div class="dashboard-header">
            <div class="dashboard-title">IRIS Databases</div>
    </div>
        </div>
        <!-- Stats Cards -->
        <!--div class="stats-container">
            <div class="stat-card total">
                <h3>Total Allocated</h3>
                <div class="stat-value" id="totalAllocated">0 MB</div>
            </div>
            <div class="stat-card used">
                <h3>Total Used</h3>
                <div class="stat-value" id="totalUsed">0 MB</div>
            </div>
            <div class="stat-card available">
                <h3>Available</h3>
                <div class="stat-value" id="totalAvailable">0 MB</div>
            </div>
            <div class="stat-card count">
                <h3>Global Count</h3>
                <div class="stat-value" id="globalCount">0</div>
            </div>
        </div-->
        <!-- Chart Section -->
        <div class="chart-container">
            <div class="chart-header">
                <h2 class="chart-title">Databases</h2>
                <div class="chart-controls">
                    <button class="btn" id="toggleChartType">
                        <i class="fas fa-chart-bar"></i> Toggle Chart
                    </button>
                    <button class="btn btn-secondary" id="resetZoom">
                        <i class="fas fa-search-minus"></i> Reset Zoom
                    </button>
                </div>
            </div>
            <p>Date: #($ZDT($h,3))#</p>
            <div class="chart-wrapper">
                <canvas id="globalsChart"></canvas>
            </div>
        </div>
        <!-- Table Section -->
        <div class="table-container">
            <div class="table-header">
                <h2 class="table-title">All Databases</h2>
                <div class="search-container">
                    <i class="fas fa-search search-icon"></i>
                    <input type="text" id="searchBox" class="search-box" placeholder="Search DB by name...">
                </div>
            </div>
            <div id="tableWrapper">
                <table id="globalsTable" class="data-table">
                    <thead>
                        <tr>
                            <th data-sort="name">Name <i class="fas fa-sort"></i></th>
                            <th data-sort="allocated">mbSize <i class="fas fa-sort"></i></th>
                            <th data-sort="used">mbAvail <i class="fas fa-sort"></i></th>
                            <th data-sort="usage">FreePrz <i class="fas fa-sort"></i></th>
                            <th data-sort="usedMB">Used MB <i class="fas fa-sort"></i></th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Filled by JavaScript -->
                    </tbody>
                </table>
                <div id="noResults" class="no-results" style="display: none;">
                    <i class="fas fa-search"></i>
                    <p>No globals found matching your search criteria.</p>
                </div>
                <div id="pagination" class="pagination">
                    <!-- Pagination buttons will be added here -->
                </div>
            </div>
        </div>
    </div>
    <div id="toast" class="toast">
        <i class="fas fa-check-circle"></i>
        <span id="toastMessage">Operation completed successfully</span>
    </div>
</body>
	>
	Do ..Scripts()
	Return $$$OK
}
ClassMethod LoadCSS()
{
	Set obj = ##class(%Dictionary.CompiledXData).%OpenId($Classname()_"||Style")
	Return:(obj = "") $$$OK
	Set xdata = obj.Data
	Set status = ##class(%XML.TextReader).ParseStream(xdata, .textreader)
	While textreader.Read() { If (textreader.NodeType="chars") { Write textreader.Value } }
	Return $$$OK
}
XData Style
{
<data>
	<![CDATA[:root{--primary-color:#4361ee;--secondary-color:#3f37c9;--accent-color:#4cc9f0;--success-color:#4caf50;--warning-color:#ff9800;--danger-color:#f44336;--dark-color:#212529;--light-color:#f8f9fa;--border-color:#dee2e6;--shadow:0 4px 6px rgba(0,0,0,0.1);--shadow-hover:0 10px 15px rgba(0,0,0,0.1)}*{box-sizing:border-box;margin:0;padding:0}body{font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif;background-color:#f5f7fb;color:var(--dark-color);line-height:1.6}.container{max-width:1400px;margin:0 auto;padding:20px}header{background:linear-gradient(135deg,var(--primary-color),var(--secondary-color));color:white;padding:15px 0;box-shadow:var(--shadow);margin-bottom:20px}header h1{text-align:center;font-weight:600;font-size:1.7rem}.dashboard-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;flex-wrap:wrap;gap:15px}.dashboard-title{font-size:1.8rem;color:var(--dark-color);font-weight:600}.namespace-selector{display:flex;align-items:center;gap:10px}
    .namespace-selector label{font-weight:500;color:var(--dark-color)}.namespace-dropdown{padding:8px 12px;border:1px solid var(--border-color);border-radius:5px;background-color:white;font-size:0.9rem;min-width:150px;cursor:pointer}.stats-container{display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:20px;margin-bottom:30px}.stat-card{background:white;border-radius:10px;padding:20px;box-shadow:var(--shadow);transition:transform .3s ease,box-shadow .3s ease;border-left:4px solid var(--primary-color)}.stat-card:hover{transform:translateY(-5px);box-shadow:var(--shadow-hover)}.stat-card h3{font-size:0.9rem;color:#6c757d;margin-bottom:10px;text-transform:uppercase;letter-spacing:0.5px}.stat-value{font-size:1.8rem;font-weight:700;color:var(--dark-color)}.stat-card.total{border-left-color:var(--primary-color)}.stat-card.used{border-left-color:var(--success-color)}.stat-card.available{border-left-color:var(--warning-color)}.stat-card.count{border-left-color:var(--accent-color)}
    .chart-container{background:white;border-radius:10px;padding:25px;box-shadow:var(--shadow);margin-bottom:30px}.chart-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:20px}.chart-title{font-size:1.4rem;font-weight:600;color:var(--dark-color)}.chart-controls{display:flex;gap:10px}.btn{padding:8px 15px;border:none;border-radius:5px;background-color:var(--primary-color);color:white;cursor:pointer;font-size:0.9rem;transition:background-color .3s ease;display:flex;align-items:center;gap:5px}.btn:hover{background-color:var(--secondary-color)}.btn-secondary{background-color:#6c757d}
    .btn-secondary:hover{background-color:#5a6268}.table-container{background:white;border-radius:10px;padding:25px;box-shadow:var(--shadow);overflow:hidden}.table-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;flex-wrap:wrap;gap:15px}.table-title{font-size:1.4rem;font-weight:600;color:var(--dark-color)}.search-container{position:relative;width:300px}.search-box{width:100%;padding:10px 15px 10px 40px;border:1px solid var(--border-color);border-radius:25px;font-size:0.9rem;transition:border-color .3s ease}.search-box:focus{outline:none;border-color:var(--primary-color);box-shadow:0 0 0 3px rgba(67,97,238,0.2)}
    .search-icon{position:absolute;left:15px;top:50%;transform:translateY(-50%);color:#6c757d}.data-table{width:100%;border-collapse:collapse}.data-table th{background-color:var(--light-color);color:var(--dark-color);font-weight:600;text-align:left;padding:12px 15px;position:sticky;top:0;z-index:10;cursor:pointer;user-select:none;transition:background-color .3s ease}.data-table th:hover{background-color:#e9ecef}.data-table th i{margin-left:5px;font-size:0.8rem;color:#6c757d}.data-table td{padding:12px 15px;border-bottom:1px solid var(--border-color)}.data-table tr:hover{background-color:rgba(67,97,238,0.05)}.data-table tr:last-child td{border-bottom:none}.usage-bar{height:8px;background-color:#e9ecef;border-radius:4px;overflow:hidden;margin-top:5px}.usage-fill{height:100%;background:linear-gradient(90deg,var(--success-color),var(--warning-color));border-radius:4px}.pagination{display:flex;justify-content:center;margin-top:20px;gap:5px}.page-btn{padding:8px 12px;border:1px solid var(--border-color);background:white;border-radius:5px;cursor:pointer;transition:all .3s ease}.page-btn:hover{background-color:var(--light-color)}.page-btn.active{background-color:var(--primary-color);color:white;border-color:var(--primary-color)}
    .no-results{text-align:center;padding:30px;color:#6c757d}
    .no-results i{font-size:3rem;margin-bottom:15px;color:#dee2e6}.loading{display:flex;justify-content:center;align-items:center;height:200px}.spinner{width:40px;height:40px;border:4px solid rgba(0,0,0,0.1);border-radius:50%;border-top-color:var(--primary-color);animation:spin 1s ease-in-out infinite}@keyframes spin{to{transform:rotate(360deg)}}.toast{position:fixed;bottom:20px;right:20px;background:white;padding:15px 20px;border-radius:5px;box-shadow:var(--shadow-hover);display:flex;align-items:center;gap:10px;transform:translateY(100px);opacity:0;transition:all .3s ease;z-index:1000}.toast.show{transform:translateY(0);opacity:1}.toast.success{border-left:4px solid var(--success-color)}.toast.error{border-left:4px solid var(--danger-color)}.toast.info{border-left:4px solid var(--primary-color)}.chart-wrapper{position:relative;height:400px;width:100%}@media(max-width:768px){.dashboard-header{flex-direction:column;align-items:flex-start}.search-container{width:100%}.chart-header{flex-direction:column;align-items:flex-start}.table-header{flex-direction:column;align-items:flex-start}.data-table{font-size:0.9rem}.data-table th,.data-table td{padding:8px 10px}.chart-wrapper{height:300px}}
]]>
	</data>
}
ClassMethod GetGlobalSize() As %String
{
	#dim response As %DynamicArray = []
	Set tResult = ##class(%SQL.Statement).%ExecDirect(,"SELECT DatabaseName,FreePrz,mbSize,mbAvail FROM %ZX.dbfree ORDER BY DATABASENAME")
	If tResult.%SQLCODE {
		Return response.%ToJSON()
	}
	While tResult.%Next() {
		Set ptr=0
		Set json = {"name":(tResult.DatabaseName)}
		Do json.%Set("allocated",tResult.mbSize,"number")
		Do json.%Set("mbSize",tResult.mbSize,"number")
		Do json.%Set("mbAvail",tResult.mbAvail,"number")
		Do json.%Set("used",(tResult.mbSize-tResult.mbAvail),"number")
		Do json.%Set("available",tResult.mbAvail,"number")
		Do json.%Set("FreePrz",tResult.FreePrz,"number")
		Do response.%Push(json)
	}
	Return response.%ToJSON()
}
ClassMethod Scripts()
{
	&HTML<
    <script language="javascript">
        // Global variables
        let globalsData = [];
        let currentPage = 1;
        const itemsPerPage = 20;
        let filteredData = [];
        let sortDirection = {};
        let chartType = 'bar';
        let currentNamespace = '%SYS';
        // DOM elements
        const tableBody = document.querySelector('#globalsTable tbody');
        const searchBox = document.getElementById('searchBox');
        const pagination = document.getElementById('pagination');
        const noResults = document.getElementById('noResults');
        const namespaceDropdown = document.getElementById('namespace');
       // Initialize the dashboard
        document.addEventListener('DOMContentLoaded', () => {
            loadNamespaceData();
            searchBox.addEventListener('input', handleSearch);
            // Add sort event listeners to table headers
            document.querySelectorAll('th[data-sort]').forEach(th => {
                th.addEventListener('click', () => handleSort(th.dataset.sort));
            });
            // Add chart control event listeners
            document.getElementById('toggleChartType').addEventListener('click', toggleChartType);
            document.getElementById('resetZoom').addEventListener('click', resetZoom);
        });
        // Load namespace data via API call
        function loadNamespaceData() {
            // Show loading state
            showLoadingState();
            // Simulate API call with setTimeout
            // In a real implementation, replace this with fetch() or axios
            setTimeout(() => {
                try {
                // Call the GetDBSize method with the namespace parameter
                // This would be your actual API call
                    const response = GetDBSize();
                // Process the response
                    globalsData = response || [];
                // Add usage percentage to each global
                    globalsData.forEach(g => {
                        g.usedMB = g.used;
               //g.usage = g.mbSize > 0 ? (g.usedMB * 100.0 / g.mbSize) : 0;
                       g.usage = g.mbSize > 0 ? (g.usedMB / g.mbSize * 100) : 0;
                    });
               // Sort by used MB initially
                    globalsData.sort((a, b) => b.usedMB - a.usedMB);
               // Reset pagination and filters
                    currentPage = 1;
                    filteredData = [...globalsData];
                    sortDirection = {};
               // Update the UI
                    updateStats();
                    renderTable();
              // Hide loading state
                    hideLoadingState();
                    showToast(`Loaded db size informations`, 'success');
                } catch (error) {
                    console.log(error);
                    console.error('Error loading db size data:', error);
                    hideLoadingState();
                    showToast('Failed to load db size data', 'error');
                }
            }, 500); // Simulate network delay
        }
        // Show loading state
        function showLoadingState() {
            // Show spinner in table
            tableBody.innerHTML = `
                <tr>
                    <td colspan="5" class="loading">
                        <div class="spinner"></div>
                    </td>
                </tr>
            `;
            // Disable controls during loading
            searchBox.disabled = true;
            document.getElementById('toggleChartType').disabled = true;
            document.getElementById('resetZoom').disabled = true;
        }
        // Hide loading state
        function hideLoadingState() {
            // Enable controls
            searchBox.disabled = false;
            document.getElementById('toggleChartType').disabled = false;
            document.getElementById('resetZoom').disabled = false;
        }
        // Update statistics cards
        function updateStats() {
            const totalAllocated = globalsData.allocated;
            const totalUsed = globalsData.used
            const totalAvailable = globalsData.available
        }
        // Handle search
        function handleSearch() {
            const filterText = searchBox.value.toLowerCase();
            filteredData = globalsData.filter(g =>
                g.name.toLowerCase().includes(filterText)
            );
            currentPage = 1;
            renderTable();
        }
        // Handle sorting
        function handleSort(sortBy) {
            // Toggle sort direction
            sortDirection[sortBy] = sortDirection[sortBy] === 'asc' ? 'desc' : 'asc';
            // Update sort icons
            document.querySelectorAll('th i').forEach(icon => {
                icon.className = 'fas fa-sort';
            });
            const icon = document.querySelector(`th[data-sort="${sortBy}"] i`);
            icon.className = sortDirection[sortBy] === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down';
            // Sort data
            filteredData.sort((a, b) => {
                let valueA = a[sortBy];
                let valueB = b[sortBy];
                if (typeof valueA === 'string') {
                    valueA = valueA.toLowerCase();
                    valueB = valueB.toLowerCase();
                }
                if (sortDirection[sortBy] === 'asc') {
                    return valueA > valueB ? 1 : -1;
                } else {
                    return valueA < valueB ? 1 : -1;
                }
            });
            currentPage = 1;
            renderTable();
        }
        // Render table with pagination
        function renderTable() {
            tableBody.innerHTML = '';
            if (filteredData.length === 0) {
                noResults.style.display = 'block';
                pagination.innerHTML = '';
             // Update chart with empty data
                updateChart([]);
                return;
            }
            noResults.style.display = 'none';
            const startIndex = (currentPage - 1) * itemsPerPage;
            const endIndex = startIndex + itemsPerPage;
            const pageData = filteredData.slice(startIndex, endIndex);
            pageData.forEach(g => {
        //console.log(JSON.stringify(g));
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${g.name}</td>
                    <td>${g.allocated.toFixed(3)}</td>
                    <td>${g.available.toFixed(3)}</td>
                    <td>${g.FreePrz.toFixed(3)}</td>
                    <td>${g.used.toFixed(3)}</td>
                    <td>
                        ${g.usage.toFixed(1)}%
                        <div class="usage-bar">
                            <div class="usage-fill" style="width: ${Math.min(g.mbSize, 100)}%"></div>
                        </div>
                    </td>
                `;
                tableBody.appendChild(row);
            });
            renderPagination();
            console.log(JSON.stringify(pageData));
            updateChart(pageData); // Update chart with current page data
        }
        // Render pagination controls
        function renderPagination() {
            pagination.innerHTML = '';
            const totalPages = Math.ceil(filteredData.length / itemsPerPage);
            if (totalPages <= 1) return;
         // Previous button
            const prevBtn = document.createElement('button');
            prevBtn.className = 'page-btn';
            prevBtn.innerHTML = '<i class="fas fa-chevron-left"></i>';
            prevBtn.disabled = currentPage === 1;
            prevBtn.addEventListener('click', () => {
                if (currentPage > 1) {
                    currentPage--;
                    renderTable();
                }
            });
            pagination.appendChild(prevBtn);
         // Page numbers
            const maxVisiblePages = 5;
            let startPage = Math.max(1, currentPage - Math.floor(maxVisiblePages / 2));
            let endPage = Math.min(totalPages, startPage + maxVisiblePages - 1);
            if (endPage - startPage < maxVisiblePages - 1) {
                startPage = Math.max(1, endPage - maxVisiblePages + 1);
            }
            for (let i = startPage; i <= endPage; i++) {
                const pageBtn = document.createElement('button');
                pageBtn.className = 'page-btn' + (i === currentPage ? ' active' : '');
                pageBtn.textContent = i;
                pageBtn.addEventListener('click', () => {
                    currentPage = i;
                    renderTable();
                });
                pagination.appendChild(pageBtn);
            }
            // Next button
            const nextBtn = document.createElement('button');
            nextBtn.className = 'page-btn';
            nextBtn.innerHTML = '<i class="fas fa-chevron-right"></i>';
            nextBtn.disabled = currentPage === totalPages;
            nextBtn.addEventListener('click', () => {
                if (currentPage < totalPages) {
                    currentPage++;
                    renderTable();
                }
            });
            pagination.appendChild(nextBtn);
        }
        // Truncate long names for chart display
        function truncateName(name, maxLength = 20) {
            if (name.length <= maxLength) return name;
            return name.substring(0, maxLength - 3) + '...';
        }
        // Update chart with current page data
        function updateChart(pageData) {
            // Sort the page data by used MB for the chart
            const sortedPageData = [...pageData].sort((a, b) => b.usedMB - a.usedMB);
            const topInPage = sortedPageData.slice(0, 10); // Take top 10 from current page
            const labels = topInPage.map(g => truncateName(g.name));
            const allocatedMB = topInPage.map(g => g.mbSize);
            const availableMB = topInPage.map(g => g.mbAvail);
            const usedMB = topInPage.map(g => g.usedMB);
            // Update chart data
            globalsChart.data.labels = labels;
            globalsChart.data.datasets[0].data = allocatedMB;
            globalsChart.data.datasets[1].data = availableMB ;
            globalsChart.data.datasets[2].data = usedMB;
            // Update chart title to show current page
            const totalPages = Math.ceil(filteredData.length / itemsPerPage);
            globalsChart.options.plugins.title.text = `Page ${currentPage} of ${totalPages} - Top ${topInPage.length} by Used MB`;
            // Update the chart
            globalsChart.update();
        }
        // Toggle chart type
        function toggleChartType() {
            // Destroy existing chart
            globalsChart.destroy();
            // Toggle chart type
            chartType = chartType === 'bar' ? 'line' : 'bar';
            chartConfig.type = chartType;
            // Create new chart
            globalsChart = new Chart(ctx, chartConfig);
            // Update chart with current page data
            const startIndex = (currentPage - 1) * itemsPerPage;
            const endIndex = startIndex + itemsPerPage;
            const pageData = filteredData.slice(startIndex, endIndex);
            updateChart(pageData);
            const icon = document.querySelector('#toggleChartType i');
            icon.className = chartType === 'bar' ? 'fas fa-chart-bar' : 'fas fa-chart-line';
            showToast(`Chart type changed to ${chartType}`, 'info');
        }
        // Reset zoom
        function resetZoom() {
            globalsChart.resetZoom();
            showToast('Chart zoom reset', 'info');
        }
        // Toast notification
        function showToast(message, type = 'success') {
            const toast = document.getElementById('toast');
            const toastMessage = document.getElementById('toastMessage');
            toast.className = `toast ${type}`;
            toastMessage.textContent = message;
         // Update icon based on type
            const icon = toast.querySelector('i');
            if (type === 'success') {
                icon.className = 'fas fa-check-circle';
            } else if (type === 'error') {
                icon.className = 'fas fa-exclamation-circle';
            } else {
                icon.className = 'fas fa-info-circle';
            }
            toast.classList.add('show');
            setTimeout(() => {
                toast.classList.remove('show');
            }, 3000);
        }
        // Chart configuration
        const chartConfig = {
            type: chartType,
            data: {
                labels: [],
                datasets: [
                    {
                        label: 'Total MB',
                        data: [],
                        backgroundColor: 'rgba(54, 162, 235, 0.6)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 1
                    },
                    {
                        label: 'Available MB',
                        data: [],
                        backgroundColor: 'rgba(255, 159, 64, 0.6)',
                        borderColor: 'rgba(255, 159, 64, 1)',
                        borderWidth: 1
                    },
                    {
                        label: 'Used MB',
                        data: [],
                        backgroundColor: 'rgba(255, 59, 48, 0.6)',
                        borderColor: 'rgba(255, 59, 48, 1)',
                        borderWidth: 1
                    }
                ]
            },
            options: {
                indexAxis: 'y', // Use horizontal bar chart for better readability
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    x: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: 'MB'
                        },
                        min: 0
                    },
                    y: {
                        ticks: {
                            autoSkip: false
                        }
                    }
                },
                plugins: {
                    legend: {
                        position: 'top',
                        labels: {
                            boxWidth: 15,
                            padding: 15
                        }
                    },
                    title: {
                        display: true,
                        text: 'Loading data...',
                        font: {
                            size: 16
                        }
                    },
                    tooltip: {
                        callbacks: {
                            title: function(context) {
                                const index = context[0].dataIndex;
                                // Get the actual data from the current page
                                const startIndex = (currentPage - 1) * itemsPerPage;
                                const pageData = filteredData.slice(startIndex, startIndex + itemsPerPage);
                                const sortedPageData = [...pageData].sort((a, b) => b.usedMB - a.usedMB);
                                const topInPage = sortedPageData.slice(0, 10);
                                return topInPage[index].name; // Show full name in tooltip
                            },
                            label: function(context) {
                                return `${context.dataset.label}: ${context.raw.toFixed(3)} MB`;
                            }
                        }
                    },
                    zoom: {
                        pan: {
                            enabled: true,
                            mode: 'y',
                            threshold: 5,
                        },
                        zoom: {
                            wheel: {
                                enabled: true,
                                speed: 0.1
                            },
                            pinch: {
                                enabled: true
                            },
                            mode: 'y',
                            limits: {
                                y: {min: 'original', max: 'original'},
                                x: {min: 'original', max: 'original'}
                            }
                        }
                    }
                }
            }
        };
        // Create Chart.js chart with zoom and pan
        const ctx = document.getElementById('globalsChart').getContext('2d');
        let globalsChart = new Chart(ctx, chartConfig);
        // Mock API function - replace with actual API call
        function GetDBSize() {
                globalsData = #server(..GetGlobalSize())#;
                globalsData = JSON.parse(globalsData);
                return globalsData
        }
    </script>
	>
	Q 1
}
ClassMethod OnPreHTTP() As %Boolean [ ServerOnly = 1 ]
{
	set SERVER=$lfs($get(%request.Data("SERVER",1)),":")
	if $ll(SERVER) do ..Remote(SERVER)
	else  do ##class(%ZX.dbfree).Load()
	quit $$$OK
}
ClassMethod Remote(SERVER As %List)
{
	set ip=$lg(SERVER,1,"127.0.0.1")
	set port=$lg(SERVER,2,1972)
	set ns="%SYS"
	set user=$lg(SERVER,3,"_SYSTEM")
	set pw=$lg(SERVER,4,"SYS")
  try {
    set conn=##class(%Net.DB.DataSource).CreateConnection(ip
                           ,port
						   ,ns
						   ,user
						   ,pw)
    set iris=conn.CreateIris()
    }
  catch { do LOG^%ETN quit }  ;; do some error handling
 #; create a local copy before a complete replacement 
 	do iris.ClassMethodVoid("%ZX.dbfree","Load")  
	kill ^||ZX
	set ^||ZX=iris.Get("^mtemp.ZXD")
	set db=""
	For  {
		set ans=iris.GetNext(1,1,0,"^mtemp.ZXD",db)
		set db=$lg(ans,1)
		set val=$lg(ans,2)
		if db="" quit
		set ^||ZX(db)=val
		}
	do conn.Close()
	kill ^mtemp.ZXD
	merge ^mtemp.ZXD=^||ZX
	quit
}
}

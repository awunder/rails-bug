var ready;

ready = function() {
    return jQuery(document).ready(function() {
        jQuery('.quantity').on("keyup change", function() {
            var calc_sol_tmp = 0;
            var calc_sol_final = 0;
            var calc_skill_tmp = 0;
            var calc_skill_final = 0;
            var calc_org_tmp = 0;
            var calc_org_final = 0;
            var result = 0;

            weight = Array.from($('[content="weight"]')).map(function(x) { return $('input', x).val() });
            solution = Array.from($('[content="solution"]')).map(function(x) { return parseFloat(x.textContent) });
            skills = Array.from($('[content="skills"]')).map(function(x) { return parseFloat(x.textContent) });
            organization = Array.from($('[content="organization"]')).map(function(x) { return parseFloat(x.textContent) });
            adjust = Array.from($('.adjust')).map(function(x) { return parseFloat($('input', x).val()) });


            // weighted_score() from application_helper.rb
            for ( var i=0; i< weight.length; i+=1 )
            {
                calc_sol_tmp += solution[i] * weight[i];
                calc_skill_tmp += skills[i] * weight[i];
                calc_org_tmp += organization[i] * weight[i];
            };
            calc_sol_final = calc_sol_tmp / weight.length || 0;
            calc_skill_final = calc_skill_tmp / weight.length || 0;
            calc_org_final = calc_org_tmp / weight.length || 0;

            // domain_statusvalue() from application_helper.rb
            result = (calc_sol_final + adjust[0] + calc_skill_final + adjust[1] + calc_org_final + adjust[2]) / 3;
            chartresult = result;
            if (result > 100) {chartresult = 100}

            // domain_pie_value() from application_helper.rb
            chartvalue = Math.ceil(chartresult/25.0) * 25;
            chartvalue2 = 100 - chartvalue;

            // update the DOM
            $('#solution_weighted').text(Math.round(calc_sol_final));
            $('#skills_weighted').text(Math.round(calc_skill_final));
            $('#organization_weighted').text(Math.round(calc_org_final));
            $('#statusvalue').text(Math.round(result) + '%');

            // update the pie chart
            var chart = Chartkick.charts["domain-status"];
            chart.getChartObject();
            chart.updateData([['', chartvalue], ['', chartvalue2]]);
            chart.redraw();
        });

        $('tbody').on('click', '.remove_row', function(event) {
            var object = this;
            confirm(I18n["defaults"]["confirmations"]["header"], I18n["defaults"]["confirmations"]["delete"], function() {
                $(object).prev('input[type=hidden]').val(1);
                $(object).closest('tr').hide();
                return event.preventDefault();
            });
        });

        $('#actionfields > tfoot').on('click', '.add_row', function(event) {
            time = new Date().getTime();
            regexp = new RegExp($(this).data('id'), 'g');
            $('table#actionfields').find('tbody').append($(this).data('row').replace(regexp, time));
            event.preventDefault();
            spinner_nav();
            spinner();
        });

        $('#achievements > tfoot, #domain_achievements > tfoot').on('click', '.add_row', function(event) {
            time = new Date().getTime();
            regexp = new RegExp($(this).data('id'), 'g');
            $('table#achievements, table#domain_achievements').find('tbody').append($(this).data('row').replace(regexp, time));
            event.preventDefault();
        });

        $('#actions > tfoot, #domain_actions > tfoot').on('click', '.add_row', function(event) {
            time = new Date().getTime();
            regexp = new RegExp($(this).data('id'), 'g');
            $('table#actions, table#domain_actions').find('tbody').append($(this).data('row').replace(regexp, time));
            event.preventDefault();
        });
    });
};


$(document).on('turbolinks:load', ready);
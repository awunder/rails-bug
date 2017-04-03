var ready;

ready = function() {

    $(document).ready(function() {
        $(function(){
            var solution = $('#action_field_solution').attr('value');
            var skills = $('#action_field_skills').attr('value');
            var organization = $('#action_field_organization').attr('value');

            $('#solution').find('#solution_' + solution).addClass('selected');
            $('#skills').find('#skills_' + skills).addClass('selected');
            $('#organization').find('#organization_' + organization).addClass('selected');
        });

        $(function(){
            $('#solution td.selectable').click(function(){
                solution.choice = $(this).attr('value');
                $('#solution td').removeClass('selected');
                $(this).addClass('selected');
                $('#action_field_solution').val(solution.choice).attr('value', solution.choice).trigger("change");
                $('#actionfield_solution').text(solution.choice);

            });
            $('#skills td.selectable').click(function(){
                skills.choice = $(this).attr('value');
                $('#skills td').removeClass('selected');
                $(this).addClass('selected');
                $('#action_field_skills').val(skills.choice).attr('value', skills.choice).trigger("change");
                $('#actionfield_skills').text(skills.choice);
            });
            $('#organization td.selectable').click(function(){
                organization.choice = $(this).attr('value');
                $('#organization td').removeClass('selected');
                $(this).addClass('selected');
                $('#action_field_organization').val(organization.choice).attr('value', organization.choice).trigger("change");
                $('#actionfield_org').text(organization.choice);
            });
        });

        $('#action_field_organization, #action_field_skills, #action_field_solution').change(function() {
            pievalue = Math.round((parseFloat($('#action_field_solution').attr('value')) +
                parseFloat($('#action_field_skills').attr('value')) +
                parseFloat($('#action_field_organization').attr('value'))) / 3);
            pievalue1 = Math.ceil(pievalue/25.0) * 25;
            pievalue2 = 100 - pievalue1;
            $('#statusvalue').text(pievalue + '%');
            $('#action_field_pievualue')
                .val(pievalue)
                .attr('value', pievalue)
                .trigger("change");
            var chart = Chartkick.charts["status"];
            chart.getChartObject();
            chart.updateData([['', pievalue1], ['', pievalue2]]);
            chart.redraw();
        });
    });


    //###############################################
    // drag&drop for achievements and actions table #
    //###############################################

    var fixHelperModified = function(e, tr) {
        var $originals = tr.children();
        var $helper = tr.clone();
        $helper.children().each(function(index)
        {
            $(this).width($originals.eq(index).width())
        });
        return $helper;
    };

    // Make table sortable
    $("#achievements.draggable tbody").sortable({
        helper: fixHelperModified,
        stop: function(event,ui) {renumber_table('#achievements')}
    }).disableSelection();
    $("#actions.draggable tbody").sortable({
        helper: fixHelperModified,
        stop: function(event,ui) {renumber_table('#actions')}
    }).disableSelection();
    $("#domain_actions.draggable tbody").sortable({
        helper: fixHelperModified,
        stop: function(event,ui) {renumber_table_domain('#domain_actions')}
    }).disableSelection();
    $("#domain_achievements.draggable tbody").sortable({
        helper: fixHelperModified,
        stop: function(event,ui) {renumber_table_domain('#domain_achievements')}
    }).disableSelection();

    //Delete button in table rows
    $('table').on('click','.remove_fields',function() {
        tableID = '#' + $(this).closest('table').attr('id');
        renumber_table(tableID);
    });

    // Renumber table rows
    function renumber_table(tableID) {
        $(tableID + " tr").each(function() {
            count = $(this).parent().children().index($(this)) + 1;
            $(this).find('.foa_rank').val(count).attr('value', count).trigger("change");
        });
    }

    function renumber_table_domain(tableID) {
        $(tableID + " tr").each(function() {
            count = $(this).parent().children().index($(this)) + 1;
            $(this).find('.domain_rank').val(count).attr('value', count).trigger("change");
        });
    }

};

$(document).on('turbolinks:load', ready);
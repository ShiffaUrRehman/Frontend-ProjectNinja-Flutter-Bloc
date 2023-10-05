import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:project_ninja/features/members/model/members_models.dart';
import 'package:project_ninja/features/members/repo/members_repo.dart';
import 'package:project_ninja/features/projects_list/models/project_model.dart';

part 'project_members_event.dart';
part 'project_members_state.dart';

class ProjectMembersBloc
    extends Bloc<ProjectMembersEvent, ProjectMembersState> {
  ProjectMembersBloc() : super(ProjectMembersInitial()) {
    on<FetchTeamLeads>(fetchTeamLeads);
    on<FetchTeamMembers>(fetchTeamMembers);
    on<FetchProjects>(fetchProject);
    on<DisplayProject>(displayProject);
    on<AddOrReplaceTeamLead>(addOrReplaceTeamLead);
    on<RemoveTeamMember>(removeTeamMember);
    on<AddTeamMember>(addTeamMember);
  }

  FutureOr<void> fetchTeamLeads(
      FetchTeamLeads event, Emitter<ProjectMembersState> emit) async {
    emit(ProjectMembersLoading());
    dynamic members = await MembersRepo.fetchAllTeamLeads();
    if (members is List<MembersModel>) {
      emit(TeamLeadsFetched(members: members));
    } else {
      emit(TeamLeadsFetchedFailed());
    }
  }

  FutureOr<void> fetchTeamMembers(
      FetchTeamMembers event, Emitter<ProjectMembersState> emit) async {
    dynamic members = await MembersRepo.fetchAllTeamMembers();
    if (members is List<MembersModel>) {
      emit(TeamMembersFetched(members: members));
    } else {
      emit(TeamMembersFetchedFailed());
    }
  }

  FutureOr<void> fetchProject(
      FetchProjects event, Emitter<ProjectMembersState> emit) async {
    dynamic response = await MembersRepo.fetchProject(event.projectId);
    if (response is Project) {
      emit(ProjectLoaded(project: response));
    } else {
      emit(Failed());
    }
  }

  FutureOr<void> displayProject(
      DisplayProject event, Emitter<ProjectMembersState> emit) {
    emit(LoadPage());
  }

  FutureOr<void> addOrReplaceTeamLead(
      AddOrReplaceTeamLead event, Emitter<ProjectMembersState> emit) async {
    dynamic response = await MembersRepo.addOrReplaceTeamLeadProject(
        event.teamLeadId, event.projectId);
    if (response == 1) {
      emit(PageReload());
    } else {
      emit(Failed());
    }
  }

  FutureOr<void> removeTeamMember(
      RemoveTeamMember event, Emitter<ProjectMembersState> emit) async {
    dynamic response = await MembersRepo.removeTeamMemberProject(
        event.teamMemberId, event.projectId);
    if (response == 1) {
      emit(PageReload());
    } else {
      emit(Failed());
    }
  }

  FutureOr<void> addTeamMember(
      AddTeamMember event, Emitter<ProjectMembersState> emit) async {
    dynamic response = await MembersRepo.addTeamMemberProject(
        event.teamMemberId, event.projectId);
    if (response == 1) {
      emit(PageReload());
    } else {
      emit(Failed());
    }
  }
}

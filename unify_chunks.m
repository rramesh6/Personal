function [consensus_struct_1, consensus_struct_2] = unify_chunks(struct_1, struct_2, key)

if key == 0

    consensus_chunks_gait = intersect(string(struct_1.chunks_gait_0), string(struct_2.chunks_gait_0));
    consensus_chunks_nongait = intersect(string(struct_1.chunks_nongait_0), string(struct_2.chunks_nongait_0));
    consensus_struct_1 = struct_1;
    consensus_struct_2 = struct_2;
    consensus_1 = ismember(string(consensus_struct_1.chunks_gait_0), string(consensus_chunks_gait));
    consensus_struct_1.F_gait_0 = consensus_struct_1.F_gait_0(:,consensus_1);
    consensus_struct_1.P_gait_0 = consensus_struct_1.P_gait_0(:,consensus_1);
    consensus_struct_1.chunks_gait_0 = consensus_struct_1.chunks_gait_0(:,consensus_1);
    consensus_2 = ismember(string(consensus_struct_2.chunks_gait_0), string(consensus_chunks_gait));
    consensus_struct_2.F_gait_0 = consensus_struct_2.F_gait_0(:,consensus_2);
    consensus_struct_2.P_gait_0 = consensus_struct_2.P_gait_0(:,consensus_2);
    consensus_struct_2.chunks_gait_0 = consensus_struct_2.chunks_gait_0(:,consensus_2);
    consensus_1 = ismember(string(consensus_struct_1.chunks_nongait_0), string(consensus_chunks_nongait));
    consensus_struct_1.F_nongait_0 = consensus_struct_1.F_nongait_0(:,consensus_1);
    consensus_struct_1.P_nongait_0 = consensus_struct_1.P_nongait_0(:,consensus_1);
    consensus_struct_1.chunks_nongait_0 = consensus_struct_1.chunks_nongait_0(:,consensus_1);
    consensus_2 = ismember(string(consensus_struct_2.chunks_nongait_0), string(consensus_chunks_nongait));
    consensus_struct_2.F_nongait_0 = consensus_struct_2.F_nongait_0(:,consensus_2);
    consensus_struct_2.P_nongait_0 = consensus_struct_2.P_nongait_0(:,consensus_2);
    consensus_struct_2.chunks_nongait_0 = consensus_struct_2.chunks_nongait_0(:,consensus_2);

elseif key == 1

    consensus_chunks_gait = intersect(string(struct_1.chunks_gait_1), string(struct_2.chunks_gait_1));
    consensus_chunks_nongait = intersect(string(struct_1.chunks_nongait_1), string(struct_2.chunks_nongait_1));
    consensus_struct_1 = struct_1;
    consensus_struct_2 = struct_2;
    consensus_1 = ismember(string(consensus_struct_1.chunks_gait_1), string(consensus_chunks_gait));
    consensus_struct_1.F_gait_1 = consensus_struct_1.F_gait_1(:,consensus_1);
    consensus_struct_1.P_gait_1 = consensus_struct_1.P_gait_1(:,consensus_1);
    consensus_struct_1.chunks_gait_1 = consensus_struct_1.chunks_gait_1(:,consensus_1);
    consensus_2 = ismember(string(consensus_struct_2.chunks_gait_1), string(consensus_chunks_gait));
    consensus_struct_2.F_gait_1 = consensus_struct_2.F_gait_1(:,consensus_2);
    consensus_struct_2.P_gait_1 = consensus_struct_2.P_gait_1(:,consensus_2);
    consensus_struct_2.chunks_gait_1 = consensus_struct_2.chunks_gait_1(:,consensus_2);
    consensus_1 = ismember(string(consensus_struct_1.chunks_nongait_1), string(consensus_chunks_nongait));
    consensus_struct_1.F_nongait_1 = consensus_struct_1.F_nongait_1(:,consensus_1);
    consensus_struct_1.P_nongait_1 = consensus_struct_1.P_nongait_1(:,consensus_1);
    consensus_struct_1.chunks_nongait_1 = consensus_struct_1.chunks_nongait_1(:,consensus_1);
    consensus_2 = ismember(string(consensus_struct_2.chunks_nongait_1), string(consensus_chunks_nongait));
    consensus_struct_2.F_nongait_1 = consensus_struct_2.F_nongait_1(:,consensus_2);
    consensus_struct_2.P_nongait_1 = consensus_struct_2.P_nongait_1(:,consensus_2);
    consensus_struct_2.chunks_nongait_1 = consensus_struct_2.chunks_nongait_1(:,consensus_2);

elseif key == 2

    consensus_chunks_gait = intersect(string(struct_1.chunks_gait_2), string(struct_2.chunks_gait_2));
    consensus_chunks_nongait = intersect(string(struct_1.chunks_nongait_2), string(struct_2.chunks_nongait_2));
    consensus_struct_1 = struct_1;
    consensus_struct_2 = struct_2;
    consensus_1 = ismember(string(consensus_struct_1.chunks_gait_2), string(consensus_chunks_gait));
    consensus_struct_1.F_gait_2 = consensus_struct_1.F_gait_2(:,consensus_1);
    consensus_struct_1.P_gait_2 = consensus_struct_1.P_gait_2(:,consensus_1);
    consensus_struct_1.chunks_gait_2 = consensus_struct_1.chunks_gait_2(:,consensus_1);
    consensus_2 = ismember(string(consensus_struct_2.chunks_gait_2), string(consensus_chunks_gait));
    consensus_struct_2.F_gait_2 = consensus_struct_2.F_gait_2(:,consensus_2);
    consensus_struct_2.P_gait_2 = consensus_struct_2.P_gait_2(:,consensus_2);
    consensus_struct_2.chunks_gait_2 = consensus_struct_2.chunks_gait_2(:,consensus_2);
    consensus_1 = ismember(string(consensus_struct_1.chunks_nongait_2), string(consensus_chunks_nongait));
    consensus_struct_1.F_nongait_2 = consensus_struct_1.F_nongait_2(:,consensus_1);
    consensus_struct_1.P_nongait_2 = consensus_struct_1.P_nongait_2(:,consensus_1);
    consensus_struct_1.chunks_nongait_2 = consensus_struct_1.chunks_nongait_2(:,consensus_1);
    consensus_2 = ismember(string(consensus_struct_2.chunks_nongait_2), string(consensus_chunks_nongait));
    consensus_struct_2.F_nongait_2 = consensus_struct_2.F_nongait_2(:,consensus_2);
    consensus_struct_2.P_nongait_2 = consensus_struct_2.P_nongait_2(:,consensus_2);
    consensus_struct_2.chunks_nongait_2 = consensus_struct_2.chunks_nongait_2(:,consensus_2);

else

    consensus_chunks_gait = intersect(string(struct_1.chunks_gait_3), string(struct_2.chunks_gait_3));
    consensus_chunks_nongait = intersect(string(struct_1.chunks_nongait_3), string(struct_2.chunks_nongait_3));
    consensus_struct_1 = struct_1;
    consensus_struct_2 = struct_2;
    consensus_1 = ismember(string(consensus_struct_1.chunks_gait_3), string(consensus_chunks_gait));
    consensus_struct_1.F_gait_3 = consensus_struct_1.F_gait_3(:,consensus_1);
    consensus_struct_1.P_gait_3 = consensus_struct_1.P_gait_3(:,consensus_1);
    consensus_struct_1.chunks_gait_3 = consensus_struct_1.chunks_gait_3(:,consensus_1);
    consensus_2 = ismember(string(consensus_struct_2.chunks_gait_3), string(consensus_chunks_gait));
    consensus_struct_2.F_gait_3 = consensus_struct_2.F_gait_3(:,consensus_2);
    consensus_struct_2.P_gait_3 = consensus_struct_2.P_gait_3(:,consensus_2);
    consensus_struct_2.chunks_gait_3 = consensus_struct_2.chunks_gait_3(:,consensus_2);
    consensus_1 = ismember(string(consensus_struct_1.chunks_nongait_3), string(consensus_chunks_nongait));
    consensus_struct_1.F_nongait_3 = consensus_struct_1.F_nongait_3(:,consensus_1);
    consensus_struct_1.P_nongait_3 = consensus_struct_1.P_nongait_3(:,consensus_1);
    consensus_struct_1.chunks_nongait_3 = consensus_struct_1.chunks_nongait_3(:,consensus_1);
    consensus_2 = ismember(string(consensus_struct_2.chunks_nongait_3), string(consensus_chunks_nongait));
    consensus_struct_2.F_nongait_3 = consensus_struct_2.F_nongait_3(:,consensus_2);
    consensus_struct_2.P_nongait_3 = consensus_struct_2.P_nongait_3(:,consensus_2);
    consensus_struct_2.chunks_nongait_3 = consensus_struct_2.chunks_nongait_3(:,consensus_2);

end
end